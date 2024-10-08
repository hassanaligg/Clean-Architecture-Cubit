import 'dart:ui';

import 'package:animate_icons/animate_icons.dart';
import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/network_image.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/chat/domain/params/pharmacy_chat_page_params_model.dart';
import 'package:dawaa24/features/chat/presentation/cubit/pharmacy_chat_cubit/pharmacy_chat_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../core/presentation/services/image_file_picker_service.dart';
import '../../../../core/presentation/widgets/back_button.dart';
import '../../../../core/presentation/widgets/custom_form_field.dart';
import '../../../../core/presentation/widgets/error_panel.dart';
import '../../../../core/presentation/widgets/loading_panel.dart';
import '../../../../core/presentation/widgets/not_implemented_widget.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../data/model/message_model.dart';
import '../widgets/chat_app_bar_widget.dart';
import '../widgets/message_widget.dart';
import '../widgets/option_widget.dart';

class PharmacyChatPage extends StatefulWidget {
  const PharmacyChatPage(
      {super.key, required this.pharmacyChatPageParamsModel});

  final PharmacyChatPageParamsModel pharmacyChatPageParamsModel;

  @override
  State<PharmacyChatPage> createState() => _PharmacyChatPageState();
}

class _PharmacyChatPageState extends State<PharmacyChatPage>
    with SingleTickerProviderStateMixin {
  late double keyboardHeight;

  ScrollController scrollController = ScrollController();
  late final PharmacyChatCubit pharmacyChatCubit;
  List<MessageModel> messageList = [];

  AnimateIconController animateIconController = AnimateIconController();
  ValueNotifier<double> opacityNotifier = ValueNotifier(0);
  ValueNotifier<bool> isAddOpenedNotifier = ValueNotifier(false);
  ValueNotifier<double> positionNotifier1 = ValueNotifier(0);
  ValueNotifier<double> positionNotifier2 = ValueNotifier(0);
  ValueNotifier<double> positionNotifier3 = ValueNotifier(0);
  ValueNotifier<double> positionNotifier4 = ValueNotifier(0);
  ValueNotifier<double> positionNotifier5 = ValueNotifier(0);
  late AnimationController _animationController;

  bool isAddOpened = false;
  double opacity = 0;
  List<PostOptionWidget> addPostChoices = [];

  @override
  void initState() {
    pharmacyChatCubit = PharmacyChatCubit(
        targetId: widget.pharmacyChatPageParamsModel.pharmacyId!);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
    addPostChoices = [
      PostOptionWidget(
        width: 50.w,
        height: 50.h,
        iconPath: Assets.images.cameraOptionImg.path,
        onTap: () => opacityNotifier.value == 0 ? () {} : onImagePick(true),
        title: "chat.camera".tr(),
      ),
      PostOptionWidget(
        width: 50.w,
        height: 50.h,
        iconPath: Assets.images.documentOptionImg.path,
        onTap: () => opacityNotifier.value == 0 ? () {} : onDocumentPick(),
        title: "chat.document".tr(),
      ),
      PostOptionWidget(
          width: 50.w,
          height: 50.h,
          iconPath: Assets.images.photoOptionImg.path,
          onTap: () => opacityNotifier.value == 0 ? () {} : onImagePick(false),
          title: "chat.photos".tr()),
      PostOptionWidget(
        width: 50.w,
        height: 50.h,
        iconPath: Assets.images.audioOptionImg.path,
        onTap: () => opacityNotifier.value == 0 ? () {} : onPress(),
        title: "chat.audio".tr(),
      ),
      PostOptionWidget(
          width: 50.w,
          height: 50.h,
          iconPath: Assets.images.locationOptionImg.path,
          onTap: () => opacityNotifier.value == 0 ? () {} : onPress(),
          title: "chat.location".tr()),
      PostOptionWidget(
          width: 50.w, height: 50.h, onTap: () => context.pop, title: ""),
    ];
    scrollController.addListener(_scrollListener);
    pharmacyChatCubit
        .getUserProfile(widget.pharmacyChatPageParamsModel.avatarUrl ?? "");
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // If the user has scrolled to the top of the ListView
    if (scrollController.position.atEdge &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !pharmacyChatCubit.state.getMoreLoading!) {
      pharmacyChatCubit.loadMoreMessages();
    }
  }

  bool openAdd() {
    FocusManager.instance.primaryFocus?.unfocus();
    isAddOpened = true;
    isAddOpenedNotifier.value = true;
    positionNotifier1.value = 320.h;
    positionNotifier2.value = 260.h;
    positionNotifier3.value = 210.h;
    positionNotifier4.value = 150.h;
    positionNotifier5.value = 100.h;
    print(animateIconController);
    if (animateIconController.isStart()) {
      animateIconController.animateToEnd();
    }
    opacityNotifier.value = 1;
    setState(() {});
    return true;
  }

  bool closeAdd() {
    isAddOpened = false;
    isAddOpenedNotifier.value = false;
    positionNotifier1.value = 20;
    positionNotifier2.value = 20;
    positionNotifier3.value = 20;
    positionNotifier4.value = 20;
    positionNotifier5.value = 20;
    if (animateIconController.isEnd()) {
      animateIconController.animateToStart();
    }
    opacityNotifier.value = 0;
    setState(() {});
    ();
    return true;
  }

  onPress() {
    closeAdd();
    "chat.coming_soon".tr().showToast(toastGravity: ToastGravity.CENTER);
  }

  onImagePick(bool isCamera) async {
    final image = isCamera
        ? await ImageFilePickerService.getInstance().pickImageFromCamera()
        : await ImageFilePickerService.getInstance().pickImageFromGallery();
    if (image != null) {
      closeAdd();
      pharmacyChatCubit.imageModeView(image, true, isCamera: isCamera);
    }
    setState(() {});
  }

  onDocumentPick() async {
    final path = await ImageFilePickerService.getInstance().pickFile(context);
    if (path != null) {
      closeAdd();
      pharmacyChatCubit.uploadFile(path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return BlocConsumer<PharmacyChatCubit, PharmacyChatState>(
      bloc: pharmacyChatCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return PopScope(
          canPop: state.image == null,
          onPopInvoked: (didPop) {
            pharmacyChatCubit.imageModeView(null, false);
          },
          child: Material(
            child: state.image != null
                ? Stack(
                    children: [
                      Positioned.fill(
                        child: Image.file(
                          state.image!,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      PositionedDirectional(
                          start: 0.w,
                          end: 0.w,
                          top: 35.h,
                          child: Container(
                            color: Colors.grey.withOpacity(0.2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.cancel,
                                      color: Colors.black, size: 30),
                                  onPressed: () {
                                    pharmacyChatCubit.imageModeView(
                                        null, false);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.check_circle,
                                      color: Colors.green, size: 30),
                                  onPressed: () {
                                    pharmacyChatCubit
                                        .uploadImage(state.image!.path);
                                  },
                                ),
                              ],
                            ),
                          )),
                    ],
                  )
                : GestureDetector(
                    onTap: closeAdd,
                    child: Stack(
                      children: [
                        Scaffold(
                          backgroundColor: AppColors.white[75],
                          resizeToAvoidBottomInset: true,
                          appBar: appBarWidget(),
                          body: BlocConsumer<PharmacyChatCubit,
                              PharmacyChatState>(
                            bloc: pharmacyChatCubit,
                            listener: (context, state) {
                              if (state.status == PharmacyChatStatus.success) {
                                //_scrollToBottom();
                              }
                            },
                            builder: (context, state) {
                              if (state.status == PharmacyChatStatus.success) {
                                return bodyWidget(state.logText);
                              } else if (state.status ==
                                  PharmacyChatStatus.loading) {
                                return const LoadingPanel();
                              } else if (state.status ==
                                  PharmacyChatStatus.error) {
                                return ErrorPanel(
                                  failure: state.failure!,
                                  onTryAgain: () {
                                    pharmacyChatCubit.initFunction();
                                  },
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          // bottomNavigationBar:
                          //     state.status == PharmacyChatStatus.loading
                          //         ? const SizedBox()
                          //         : bottomWidget(),
                        ),
                        if (isAddOpened)
                          BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              color: Colors.black.withOpacity(
                                  0), // This makes sure the blur is visible
                            ),
                          ),
                        ValueListenableBuilder(
                          valueListenable: positionNotifier1,
                          builder: (context, double p, __) {
                            return AnimatedPositionedDirectional(
                              duration: const Duration(milliseconds: 300),
                              bottom: p,
                              start: 20.w,
                              child: ValueListenableBuilder(
                                valueListenable: opacityNotifier,
                                builder: (context, double p, __) {
                                  return AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: p,
                                    child: Row(
                                      children: [addPostChoices[0]],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: positionNotifier2,
                          builder: (context, double p, __) {
                            return AnimatedPositionedDirectional(
                              duration: const Duration(milliseconds: 300),
                              bottom: p,
                              start: 20.w,
                              child: ValueListenableBuilder(
                                valueListenable: opacityNotifier,
                                builder: (context, double p, __) {
                                  return AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: p,
                                    child: Row(
                                      children: [addPostChoices[1]],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: positionNotifier3,
                          builder: (context, double p, __) {
                            return AnimatedPositionedDirectional(
                              duration: const Duration(milliseconds: 300),
                              bottom: p,
                              start: 20.w,
                              child: ValueListenableBuilder(
                                valueListenable: opacityNotifier,
                                builder: (context, double p, __) {
                                  return AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: p,
                                    child: Row(
                                      children: [addPostChoices[2]],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: positionNotifier4,
                          builder: (context, double p, __) {
                            return AnimatedPositionedDirectional(
                              duration: const Duration(milliseconds: 300),
                              bottom: p,
                              start: 20.w,
                              child: ValueListenableBuilder(
                                valueListenable: opacityNotifier,
                                builder: (context, double p, __) {
                                  return AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: p,
                                    child: Row(
                                      children: [addPostChoices[3]],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: positionNotifier5,
                          builder: (context, double p, __) {
                            return AnimatedPositionedDirectional(
                              duration: const Duration(milliseconds: 300),
                              bottom: p,
                              start: 20.w,
                              child: ValueListenableBuilder(
                                valueListenable: opacityNotifier,
                                builder: (context, double p, __) {
                                  return AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: p,
                                    child: Row(
                                      children: [addPostChoices[4]],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        if (state.status != PharmacyChatStatus.loading)
                          Positioned(
                              bottom: 10.h,
                              right: 0,
                              left: 0,
                              child: bottomWidget())
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget appBarWidget() {
    return ChatAppBar(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomBackButton(
            color: Colors.black,
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 34.w,
            height: 34.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: CustomNetworkImage(
                url: pharmacyChatCubit.state.userAvtarUrl,
                boxFit: BoxFit.cover,
                errorIcon: Assets.icons.person,
                borderRadius: BorderRadius.zero,
                backgroundColor: HexColor.fromHex('#EFF3F5'),
                errorPadding: 5,
                isBase64: true,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.pharmacyChatPageParamsModel.pharmacyName ?? '',
                    style: Theme.of(context).textTheme.displaySmall),
                if ((pharmacyChatCubit.state.status !=
                        PharmacyChatStatus.error &&
                    pharmacyChatCubit.state.status !=
                        PharmacyChatStatus.loading))
                  if (pharmacyChatCubit.state.status !=
                      PharmacyChatStatus.loading)
                    Text(
                      pharmacyChatCubit.state.isOnline!
                          ? "chat.online".tr()
                          : pharmacyChatCubit.getLastSeen(context),
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 11.sp,
                            color: pharmacyChatCubit.state.isOnline!
                                ? HexColor.fromHex("#25D0BD")
                                : HexColor.fromHex('#1DA4CA'),
                          ),
                    ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        NotImplementedWidget(
          otherSnackBar: true,
          child: CustomSvgIcon(
            Assets.icons.callIcon,
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        NotImplementedWidget(
          otherSnackBar: true,
          child: CustomSvgIcon(
            Assets.icons.videoIcon,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }

  Widget bodyWidget(List<MessageModel> textList) {
    return Padding(
      padding: EdgeInsets.only(bottom: 100.h),
      child: ListView.separated(
        controller: scrollController,
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50.h),
        itemCount: textList.length + 1,
        itemBuilder: (context, index) {
          if (index == textList.length) {
            return const SizedBox.shrink(); // Placeholder for end of list
          }

          final currentMessage = textList[textList.length - index - 1];
          final previousMessage = index < textList.length - 1
              ? textList[textList.length - index - 2]
              : null;

          bool showDateHeader = previousMessage == null ||
              !isSameDate(currentMessage.timestamp, previousMessage.timestamp);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showDateHeader) buildDateHeader(currentMessage.timestamp),
              MessageWidget(
                messageItem: currentMessage,
                profileImage: pharmacyChatCubit.state.userAvtarUrl,
              ),
              if (pharmacyChatCubit.state.isUploading! && index == 0)
                Center(
                    child: CupertinoActivityIndicator(
                  color: AppMaterialColors.green[200]!,
                )),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10.h);
        },
      ),
    );
  }

  bottomWidget() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 45.h,
              decoration: BoxDecoration(
                  color: !isAddOpened
                      ? AppColors.grey[400]!.withOpacity(0.4)
                      : HexColor.fromHex('#53ADF3'),
                  shape: BoxShape.circle),
              child: RotationTransition(
                turns:
                    Tween(begin: 0.0, end: 1.0).animate(_animationController),
                child: Center(
                  child: AnimateIcons(
                    startIcon: Icons.add,
                    endIcon: Icons.arrow_drop_down,
                    size: 20.0.sp,
                    controller: animateIconController,
                    onStartIconPress: openAdd,
                    onEndIconPress: closeAdd,
                    duration: const Duration(milliseconds: 300),
                    startIconColor: AppColors.black,
                    endIconColor: AppColors.white,
                    clockwise: false,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: CustomFormField(
                hintText: "chat.type".tr(),
                controller: pharmacyChatCubit.state.textEditingController,
                boarderRadius: 25.r,
                maxLines: 3,
                maxLength:
                    pharmacyChatCubit.state.textEditingController.text.length >=
                            1000
                        ? 1000
                        : null,
                textInputAction: TextInputAction.next,
                fillColor: AppColors.white,
                onChange: (p0) {
                  pharmacyChatCubit.checkMaxFiledLength();
                },
                onTap: () {
                  closeAdd();
                },
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            InkWell(
              child: Transform.rotate(
                angle: context.isArabic ? 3.2 : 0,
                child: CustomSvgIcon(
                  Assets.icons.sendIcon,
                ),
              ),
              onTap: () {
                if (pharmacyChatCubit.state.textEditingController.text
                    .trim()
                    .isNotEmpty) {
                  pharmacyChatCubit.sendMessage(
                      pharmacyChatCubit.state.textEditingController.text);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildDateHeader(DateTime date) {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));

    bool isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    bool isYesterday = date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: isToday
            ? Text(
                "chat.today".tr(),
                style: (Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold)),
              )
            : isYesterday
                ? Text(
                    "chat.yesterday".tr(),
                    style: (Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
                  )
                : Text(
                    DateFormat.yMMMd(context.isArabic ? "ar" : "en")
                        .format(date),
                    style: (Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
                  ),
      ),
    );
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
