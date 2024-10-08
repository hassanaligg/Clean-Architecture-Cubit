import 'dart:developer';
import 'dart:io';

import 'package:dawaa24/core/data/enums/camera_permission_status_enum.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_color.dart';
import 'package:dawaa24/core/presentation/widgets/back_button.dart';
import 'package:dawaa24/core/presentation/widgets/custom_button.dart';
import 'package:dawaa24/core/presentation/widgets/custom_container.dart';
import 'package:dawaa24/core/presentation/widgets/error_panel.dart';
import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:dawaa24/core/presentation/widgets/loading_panel.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/core/utils/failures/failures.dart';
import 'package:dawaa24/features/pharmacies/presentation/cubits/scan_qr_pharmacy/scan_qr_pharmacy_cubit.dart';
import 'package:dawaa24/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

import '../../../../core/presentation/services/image_file_picker_service.dart';

class ScanQrPharmacyPage extends StatefulWidget {
  const ScanQrPharmacyPage({super.key});

  @override
  State<ScanQrPharmacyPage> createState() => _ScanQrPharmacyPageState();
}

class _ScanQrPharmacyPageState extends State<ScanQrPharmacyPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  late final ScanQrPharmacyCubit scanQrPharmacyCubit;
  List<File> images = [];

  @override
  void initState() {
    scanQrPharmacyCubit = ScanQrPharmacyCubit();
    handleCameraPermission();

    super.initState();
  }

  void handleCameraPermission() async {
    if (await checkPermanentlyDenied()) {
      log("Already permission is denied");
      scanQrPharmacyCubit.changeCameraPermissionStatus(
          CameraPermissionStatusEnum.cameraPermissionDenied);
    } else {
      if (await checkPermissionStatus()) {
        log("Already permission is granted");
        scanQrPharmacyCubit.changeCameraPermissionStatus(
            CameraPermissionStatusEnum.cameraPermissionGranted);
      } else {
        requestPermission();
      }
    }
  }

  Future<void> requestPermission() async {
    const permission = Permission.camera;

    if (await permission.isDenied) {
      final result = await permission.request();
      if (result.isGranted) {
        log("Permission is granted");
        scanQrPharmacyCubit.changeCameraPermissionStatus(
            CameraPermissionStatusEnum.cameraPermissionGranted);
      } else if (result.isDenied) {
        log("Permission is denied");
        scanQrPharmacyCubit.changeCameraPermissionStatus(
            CameraPermissionStatusEnum.cameraPermissionDenied);
      } else if (result.isPermanentlyDenied) {
        log("Permission is permanently denied");
        scanQrPharmacyCubit.changeCameraPermissionStatus(
            CameraPermissionStatusEnum.cameraPermissionDenied);
      }
    }
  }

  Future<bool> checkPermissionStatus() async {
    const permission = Permission.camera;
    return await permission.status.isGranted;
  }

  Future<bool> checkPermanentlyDenied() async {
    const permission = Permission.camera;

    return await permission.status.isPermanentlyDenied;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 19, 21, 1),
        title: Text(
          "qr_pharmacy.Scan_QR_code".tr(),
          style: const TextStyle(color: Colors.white),
        ),
        leading: const CustomBackButton(
          color: AppColors.white,
        ),
        actions: [
          BlocBuilder<ScanQrPharmacyCubit, ScanQrPharmacyState>(
            bloc: scanQrPharmacyCubit,
            builder: (context, state) {
              if (state.cameraPermissionStatus ==
                  CameraPermissionStatusEnum.cameraPermissionGranted) {
                return IconButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                    },
                    icon: const Icon(
                      Icons.flash_on,
                      color: AppColors.white,
                    ));
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
      body: BlocConsumer<ScanQrPharmacyCubit, ScanQrPharmacyState>(
        bloc: scanQrPharmacyCubit,
        listener: (context, state) {
          if (state.status == ScanQrPharmacyStatus.success) {
            log("status: success navigate to pharmacy Details");
            context.push(AppPaths.pharmacies.pharmacyDetails,
                extra: state.pharmacyModel);
          }
        },
        builder: (context, state) {
          return (state.cameraPermissionStatus ==
                  CameraPermissionStatusEnum.cameraPermissionUnknown)
              ? const LoadingPanel()
              : (state.cameraPermissionStatus ==
                      CameraPermissionStatusEnum.cameraPermissionDenied)
                  ? ErrorPanel(
                      failure: CustomFailure(
                          message:
                              "qr_pharmacy.don't_have_camera_permission".tr()),
                    )
                  : Column(
                      children: <Widget>[
                        Expanded(
                            child: Stack(
                          children: [
                            _buildQrView(context),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 100.h),
                                child: CustomButton(
                                  onTap: () async {
                                    final image = await ImageFilePickerService
                                            .getInstance()
                                        .pickImageFromGallery();
                                    if (image != null) {
                                      images.add(image);
                                      setState(() {});
                                    }
                                    if (images.isNotEmpty) {
                                      try {
                                        String? result =
                                            await Scan.parse(images[0].path);
                                        images = [];
                                        await controller!.pauseCamera();
                                        scanQrPharmacyCubit
                                            .scanPharmacyQR(result.toString());
                                        log("decodeQr:: $result");
                                      } catch (e) {
                                        images = [];
                                        await controller!.resumeCamera();
                                        "image_error".showToast(
                                            toastGravity: ToastGravity.CENTER);
                                        log("decodeQr error::$e");
                                      }
                                    }
                                  },
                                  width: .5.sw,
                                  height: 50.h,
                                  raduis: 25.r,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                        'qr_pharmacy.Upload from gallery'.tr(),
                                        style:
                                            context.textTheme.headlineSmall!),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            (state.status == ScanQrPharmacyStatus.loading)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: 14.h,
                                        bottom: MediaQuery.of(context)
                                                .padding
                                                .bottom +
                                            14.h),
                                    child: const LoadingBanner(),
                                  )
                                : (state.failure != null)
                                    ? Column(
                                        children: [
                                          /*Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: ErrorBanner(
                                                failure: state.failure!),
                                          ),*/
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                            'qr_pharmacy.QR_Code_is_not_working?'
                                                .tr(),
                                            style: context
                                                .textTheme.displayMedium!
                                                .copyWith(color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                            "qr_pharmacy.Send feedback to us"
                                                .tr(),
                                            style: context
                                                .textTheme.headlineSmall!
                                                .copyWith(color: Colors.white),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16.h,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomContainer(
                                                  borderRadius: 30.r,
                                                  borderColor: Colors.white,
                                                  backgroundColor: Colors.black,
                                                  marginRight: 10,
                                                  marginLeft: 10,
                                                  child: TextButton(
                                                    child: Text(
                                                      'qr_pharmacy.try_again'
                                                          .tr(),
                                                      style: context.textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    onPressed: () async {
                                                      scanQrPharmacyCubit
                                                          .reSetFailure();
                                                      await controller!
                                                          .resumeCamera();
                                                    },
                                                  ),
                                                ),
                                                CustomContainer(
                                                  borderRadius: 30.r,
                                                  borderColor: Colors.white,
                                                  backgroundColor: Colors.black,
                                                  marginRight: 10,
                                                  marginLeft: 10,
                                                  child: TextButton(
                                                    child: Text(
                                                      'qr_pharmacy.Send_Feedback'
                                                          .tr(),
                                                      style: context.textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .padding
                                                      .bottom +
                                                  8.h),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 27.h),
                                                child: Text(
                                                  'qr_pharmacy.Pharmacy_finder'
                                                      .tr(),
                                                  style: context
                                                      .textTheme.displayMedium!
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              // Padding(
                                              //   padding:
                                              //       EdgeInsets.only(bottom: 27.h),
                                              //   child: Text(
                                              //     "qr_pharmacy.Locate_nearby_pharmacies"
                                              //         .tr(),
                                              //     style: context
                                              //         .textTheme.headlineSmall!
                                              //         .copyWith(
                                              //             color: Colors.white),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ),
                          ],
                        )
                      ],
                    );
        },
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: context.theme.primaryColor,
        borderRadius: 35.r,
        borderLength: 30,
        borderWidth: 6,
        cutOutSize: 225.w,
        overlayColor: const Color.fromRGBO(2, 19, 21, 1).withOpacity(0.3),
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();
      scanQrPharmacyCubit.scanPharmacyQR(scanData.code.toString());
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
