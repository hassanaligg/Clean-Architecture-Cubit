import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:dawaa24/core/presentation/widgets/not_implemented_widget.dart';
import 'package:dawaa24/core/services/share_service.dart';
import 'package:dawaa24/router.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import '../../../../core/domain/params/show_image_params.dart';
import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../core/services/launch_service.dart';
import '../../../../core/utils/extentions.dart';
import '../../../../di/injection.dart';
import '../../data/model/message_model.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    super.key,
    required this.messageItem,
    required this.profileImage,
  });

  final MessageModel messageItem;
  final String profileImage;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  late ShareService shareService;

  @override
  void initState() {
    shareService = getIt<ShareService>();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: !context.isArabic
          ? (widget.messageItem.isSender
              ? TextDirection.ltr
              : TextDirection.rtl)
          : widget.messageItem.isSender
              ? TextDirection.rtl
              : TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.messageItem.isSender)
            Container(
              width: 34.w,
              height: 34.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: CustomNetworkImage(
                  url: widget.profileImage,
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
          getMessageBody(widget.messageItem)
        ],
      ),
    );
  }

  getMessageBody(MessageModel item) {
    if (item.messageType == MessageType.IMAGE) {
      return SizedBox(
        width: 250.w,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.push(AppPaths.externalPaths.showImage,
                          extra: ShowImageParams(
                            image: item.imagePath!,
                            isBase64: false,
                          ));
                    },
                    child: CustomNetworkImage(
                      url: item.imagePath!,
                      boxFit: BoxFit.cover,
                      width: 250.w,
                      height: 200.h,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    shareService.shareImage(item.imagePath ?? "");
                  },
                  child: Container(
                    width: 40.w,
                    height: 45.h,
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.grey[400]!.withOpacity(0.5),
                    ),
                    child: Center(
                      child: CustomSvgIcon(
                        Assets.icons.uploadIcon,
                        size: 30.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // if (!item.isReceive)
                //   CustomSvgIcon(
                //     Assets.icons.checkMessage,
                //   ),
                // if (!item.isReceive)
                //   SizedBox(
                //     width: 5.w,
                //   ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  widget.messageItem.timestamp.getTime24(),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: HexColor.fromHex('#88A4AC')),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (item.messageType == MessageType.VOICE) {
      return const SizedBox();
    }
    {
      return item.messageType == MessageType.FILE ||
              item.messageType == MessageType.TXT
          ? Flexible(
              child: InkWell(
                onTap: () async {
                  if (item.messageType == MessageType.FILE) {
                    LunchUrlService().launchUri(item.filePath);
                  }
                },
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                      end: 30.w, start: 5.w, top: 5.h, bottom: 5.h),
                  decoration: BoxDecoration(
                    color: !widget.messageItem.isSender
                        ? HexColor.fromHex('#1DA4CA')
                        : HexColor.fromHex('#EFF3F5'),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: widget.messageItem.isSender
                          ? Radius.circular(16.r)
                          : Radius.circular(5.r),
                      topEnd: Radius.circular(24.r),
                      bottomEnd: Radius.circular(24.r),
                      bottomStart: !widget.messageItem.isSender
                          ? Radius.circular(16.r)
                          : Radius.circular(5.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.messageType == MessageType.FILE)
                        Container(
                          width: 40.w,
                          height: 45.h,
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grey[400]!.withOpacity(0.5),
                          ),
                          child: Center(
                            child: CustomSvgIcon(
                              Assets.icons.fileIcon,
                            ),
                          ),
                        ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("isDelivery :: ${widget.messageItem.isDelivery.toString()}"),
                            // Text("isRead :: ${widget.messageItem.isRead.toString()}"),
                            getMessageText(
                                isText: widget.messageItem.messageType !=
                                    MessageType.FILE),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (!item.isSender)
                                  CustomSvgIcon(
                                    Assets.icons.checkMessage,
                                  ),
                                if (!item.isSender)
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                Text(
                                  widget.messageItem.timestamp.getTime24(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          color: widget.messageItem.isSender
                                              ? HexColor.fromHex('#88A4AC')
                                              : AppMaterialColors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox();
    }
  }

  getMessageText({bool isText = true}) {
    return isText
        ? ReadMoreText(
            widget.messageItem.message.trim(),
            trimMode: TrimMode.Line,
            trimLines: 10,
            trimCollapsedText: 'chat.read_more'.tr(),
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: widget.messageItem.isSender
                  ? AppMaterialColors.black
                  : AppMaterialColors.white,
            ),
            trimExpandedText: '',
            moreStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: !widget.messageItem.isSender
                    ? AppMaterialColors.white
                    : AppMaterialColors.green.shade200),
          )
        : Text(widget.messageItem.fileName!,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: widget.messageItem.isSender
                    ? AppMaterialColors.black
                    : AppMaterialColors.white));
  }
}
