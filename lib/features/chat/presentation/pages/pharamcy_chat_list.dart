import 'dart:developer';

import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/widgets/loading_panel.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/main/presentation/cubits/main_page_cubit/main_page_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../core/presentation/widgets/back_button.dart';
import '../../../../core/presentation/widgets/custom_form_field.dart';
import '../../../../core/presentation/widgets/error_panel.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../../../router.dart';
import '../../../main/presentation/cubits/main_page_cubit/main_page_cubit.dart';
import '../../domain/params/pharmacy_chat_page_params_model.dart';
import '../cubit/pharmacy_chat_cubit/pharmacy_chat_cubit.dart';
import '../widgets/chat_widget.dart';

class PharmacyChatListPage extends StatefulWidget {
  const PharmacyChatListPage({super.key});

  @override
  State<PharmacyChatListPage> createState() => _PharmacyChatListPageState();
}

class _PharmacyChatListPageState extends State<PharmacyChatListPage> {
  late final TextEditingController searchController;
  late final PharmacyChatCubit pharmacyChatCubit;

  @override
  void initState() {
    searchController = TextEditingController();
    pharmacyChatCubit = PharmacyChatCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageCubit, MainPageState>(
      builder: (context, state) {
        return BlocConsumer<PharmacyChatCubit, PharmacyChatState>(
          bloc: pharmacyChatCubit,
          listener: (context, state) {},
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                pharmacyChatCubit.initFunction();
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "chat.chat".tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // leading: CustomBackButton(
                  //   color: context.isDark ? AppColors.white : AppColors.black,
                  //   size: 15.w,
                  // ),
                ),
                body: state.status == PharmacyChatStatus.loading
                    ? const LoadingPanel()
                    : state.status == PharmacyChatStatus.error
                        ? ErrorPanel(
                            failure: state.failure!,
                            onTryAgain: () {
                              pharmacyChatCubit.initFunction();
                            },
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: Column(
                              children: [
                                CustomFormField(
                                  hintText: "chat.search_chat".tr(),
                                  controller: searchController,
                                  boarderRadius: 12.r,
                                  textInputAction: TextInputAction.next,
                                  fillColor: AppColors.white,
                                  prefixIconWidth: 50.w,
                                  hintStyle: TextStyle(
                                      color: HexColor.fromHex('#77738F')),
                                  prefixIcon: CustomSvgIcon(Assets.icons.search,
                                      color: HexColor.fromHex('#77738F')),
                                  onChange: (search) {
                                    pharmacyChatCubit.searchChat(search);
                                  },
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                ((searchController.text.isNotEmpty &&
                                            pharmacyChatCubit
                                                .state
                                                .filteredConversation!
                                                .isEmpty) &&
                                        pharmacyChatCubit
                                            .state.allConversation!.isNotEmpty)
                                    ? Center(
                                        child: Text(
                                          "chat.no_result".tr(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(fontSize: 16.sp),
                                        ),
                                      )
                                    : (pharmacyChatCubit
                                            .state.allConversation!.isEmpty)
                                        ? Center(
                                            child: Text(
                                              "chat.no_conversations".tr(),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(fontSize: 16.sp),
                                            ),
                                          )
                                        : Expanded(
                                            child: ListView.separated(
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                final chatList = searchController
                                                        .text.isEmpty
                                                    ? state.allConversation
                                                    : state
                                                        .filteredConversation;

                                                if (index >= chatList!.length) {
                                                  return const SizedBox
                                                      .shrink();
                                                }

                                                final chatModel =
                                                    chatList[index];

                                                return InkWell(
                                                  onTap: () {
                                                    try {
                                                      pharmacyChatCubit
                                                          .makeConversationRead(
                                                              chatModel
                                                                  .conversationId!)
                                                          .then((value) async {
                                                        context
                                                            .push(
                                                          AppPaths.chatPaths
                                                              .pharmacyChatPage,
                                                          extra:
                                                              PharmacyChatPageParamsModel(
                                                            pharmacyName: chatModel
                                                                    .userInfo
                                                                    ?.nickName ??
                                                                'Pharmacy',
                                                            pharmacyId: chatModel
                                                                    .userInfo
                                                                    ?.userId ??
                                                                '',
                                                            avatarUrl: chatModel
                                                                .userInfo!
                                                                .avatarUrl,
                                                          ),
                                                        )
                                                            .then(
                                                          (value) {
                                                            pharmacyChatCubit
                                                                .getHistoricChats(
                                                                    withLoading:
                                                                        false);
                                                          },
                                                        );
                                                      });
                                                    } catch (e) {
                                                      log(e.toString());
                                                    }
                                                  },
                                                  child: ChatWidget(
                                                      chatModel: chatModel),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height: 25.h,
                                                );
                                              },
                                              itemCount:
                                                  searchController.text.isEmpty
                                                      ? state.allConversation!
                                                          .length
                                                      : state
                                                          .filteredConversation!
                                                          .length,
                                            ),
                                          ),
                                SizedBox(
                                  height: 90.h,
                                )
                              ],
                            ),
                          ),
              ),
            );
          },
        );
      },
    );
  }
}
