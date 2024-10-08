import 'package:dawaa24/core/presentation/widgets/error_banner.dart';
import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:dawaa24/features/address/presentation/cubits/address_list_cubit/address_list_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../core/presentation/widgets/back_button.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/custom_pop_up.dart';
import '../../../../core/presentation/widgets/paginated_list.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../../../router.dart';
import '../cubits/address_list_cubit/address_list_state.dart';
import '../widgets/address_list_widget.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  late AddressListCubit addressListCubit;

  @override
  void initState() {
    addressListCubit = AddressListCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressListCubit, AddressListState>(
      bloc: addressListCubit,
      listener: (context, state) {
        if (state.status == AddressListStatus.updated) {
          Fluttertoast.showToast(
              msg: "address.address_update_successful".tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.sp);
          context.pop(true);
        } else if (state.status == AddressListStatus.deleted) {
          Fluttertoast.showToast(
              msg: "address.address_deleted".tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.sp);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbar(
            title: 'address.manage_addresses'.tr(),
            leading: CustomBackButton(
              color: Colors.black,
              size: 18.sp,
            ),
            isGradients: false,
          ),
          body: addressListCubit.state.status == AddressListStatus.loading
              ? const LoadingBanner()
              : Column(
                  children: [
                    if (addressListCubit.state.status ==
                        AddressListStatus.error)
                      ErrorBanner(failure: state.addressFailure!),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'address.choose_delivery_location'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 18.sp),
                          ),
                          InkWell(
                            onTap: () async {
                              await context
                                  .push(AppPaths.address.addNewAddress);
                              addressListCubit.paginationCubit.load(false);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add_circle_outline,
                                    color: AppMaterialColors.green.shade200),
                                SizedBox(width: 6.w),
                                Text(
                                  "address.add_new".tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color:
                                              AppMaterialColors.green.shade200),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PaginatedList<AddressModel>(
                        paginationCubit: addressListCubit.paginationCubit,
                        itemBuilder: (item) => AddressListWidget(
                          onTap: () {
                            _showPopupDefault(context, item);
                          },
                          addressModel: item,
                          onDelete: () {
                            _showPopup(context, item);
                          },
                          onUpdate: () async {
                            await context.push(AppPaths.address.addNewAddress,
                                extra: item);
                            addressListCubit.paginationCubit.load(false);
                          },
                        ),
                        separator: Padding(
                          padding: EdgeInsetsDirectional.only(start: 20.w),
                          child: Container(
                              height: 1,
                              color: AppMaterialColors.grey.shade400),
                        ),
                        noData: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomSvgIcon(Assets.images.noResultSearch,
                                  size: 220.w),
                              SizedBox(
                                height: 24.h,
                              ),
                              Text(
                                "address.no_List".tr(),
                                style: context.textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              SizedBox(
                                width: 280.w,
                                child: Text(
                                  "",
                                  style: context.textTheme.titleSmall,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        padding: EdgeInsetsDirectional.only(end: 20.w),
                      ),
                    ),
                  ],
                ),
          // bottomNavigationBar: Padding(
          //   padding: EdgeInsets.fromLTRB(
          //       20.w, 10.h, 20.w, MediaQuery.of(context).padding.bottom),
          //   child: CustomContainer(
          //     height: 50,
          //     width: MediaQuery.of(context).size.width,
          //     borderRadius: 10,
          //     gradient: AppGradients.greenGradient,
          //     child: TextButton(
          //       child: Text(
          //         "address.continue".tr(),
          //         style: Theme.of(context)
          //             .textTheme
          //             .titleSmall!
          //             .copyWith(color: AppMaterialColors.white),
          //       ),
          //       onPressed: () {},
          //     ),
          //   ),
          // ),
        );
      },
    );
  }

  void _showPopup(BuildContext context, AddressModel address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: "${'address.delete_address'.tr()} ${address.name}",
          icon: Center(
            child: CustomSvgIcon(
              Assets.icons.addressWarningIcon,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: const BorderSide(color: Colors.black))),
                  backgroundColor: WidgetStateProperty.all(
                    AppMaterialColors.white,
                  ),
                  surfaceTintColor: WidgetStateProperty.all(
                    AppMaterialColors.white,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    AppMaterialColors.white,
                  ),
                  shadowColor: WidgetStateProperty.all(
                    Colors.transparent,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Text(
                    'address.cancel'.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  )),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (address.isDefault!) {
                    Fluttertoast.showToast(
                        msg: "address.delete_default_address".tr(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.sp);
                    return;
                  }
                  addressListCubit.deleteAddress(address.id!);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Text(
                    'address.remove'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppMaterialColors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPopupDefault(BuildContext context, AddressModel address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: 'address.address_as_default'.tr(),
          icon: Center(
            child: CustomSvgIcon(
              Assets.icons.addressWarningIcon,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: const BorderSide(color: Colors.black))),
                  backgroundColor: WidgetStateProperty.all(
                    AppMaterialColors.white,
                  ),
                  surfaceTintColor: WidgetStateProperty.all(
                    AppMaterialColors.white,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    AppMaterialColors.white,
                  ),
                  shadowColor: WidgetStateProperty.all(
                    Colors.transparent,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Text(
                    'address.cancel'.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  )),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  addressListCubit.makeAddressDefault(address.id!);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Text(
                    'drawer.Yes'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppMaterialColors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
