import 'dart:convert';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:agora_chat_sdk/src/models/chat_message.dart';
import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/features/chat/data/model/chat_list_model.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dawaa24/core/presentation/widgets/network_image.dart';

import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../core/utils/extentions.dart';
import '../../../../di/injection.dart';

class ChatWidget extends StatelessWidget {
  final ChatListModel chatModel;

  const ChatWidget({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 55.h,
                    width: 55.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FutureBuilder<String?>(
                          future: getUserAvatar(
                              chatModel.userInfo!.avatarUrl ?? ""),
                          builder: (context, snapshot) {
                            return CustomNetworkImage(
                              url: snapshot.data.toString(),
                              boxFit: BoxFit.cover,
                              errorIcon: Assets.icons.person,
                              borderRadius: BorderRadius.zero,
                              backgroundColor: HexColor.fromHex('#EFF3F5'),
                              errorPadding: 5,
                              isBase64: true,
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 0.4.sw,
                              child: Text(
                                getProviderName(chatModel),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                            getDateWithTime(
                                date: chatModel.timestamp,
                                context: context,
                                time: chatModel.lastMessage!.serverTime
                                    .toReadableDate()),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                getMessage(chatModel.lastMessage),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 11.sp,
                                        color: HexColor.fromHex('#636D78')),
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (chatModel.unreadMessage != 0)
                PositionedDirectional(
                  end: 0,
                  bottom: 0,
                  child: Container(
                    height: 25.h,
                    width: 25.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: HexColor.fromHex('#008B99')),
                    child: Center(
                      child: Text(
                        chatModel.unreadMessage.toString(),
                        style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Divider(
            color: HexColor.fromHex('#D8DEF5'),
          )
        ],
      ),
    );
  }

  String getProviderName(ChatListModel chatModel) {
    if (chatModel.userInfo!.nickName != null) {
      return chatModel.userInfo!.nickName!.isNotEmpty
          ? chatModel.userInfo!.nickName!
          : "Pharmacy";
    }
    return "Pharmacy";
  }

  String getTime(String time, BuildContext context) {
    String convertedCreateTime = time.convertArabicIndicToArabicNumerals();
    DateTime date = DateTime.parse(convertedCreateTime);
    return date.getTime(context);
  }

  String getMessage(ChatMessage? lastMessage) {
    try {
      switch (lastMessage!.body.type) {
        case MessageType.TXT:
          return (lastMessage.body as ChatTextMessageBody).content;
        case MessageType.IMAGE:
          return "chat.image_message".tr();
        case MessageType.VOICE:
          return "";
        case MessageType.VIDEO:
          return "";
        case MessageType.FILE:
          return "chat.file_message".tr();
        default:
          break;
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  Widget getDateWithTime(
      {required DateTime date,
      required BuildContext context,
      required String time}) {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));

    bool isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    bool isYesterday = date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;

    return isToday
        ? Text(
            "${"chat.today".tr()} ${getTime(time, context)}",
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: HexColor.fromHex('#88A4AC')),
          )
        : isYesterday
            ? Text("${"chat.yesterday".tr()} ${getTime(time, context)}",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: HexColor.fromHex('#88A4AC')))
            : Text(
                DateFormat.yMMMd(context.isArabic ? "ar" : "en").format(date),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: HexColor.fromHex('#88A4AC')),
              );
  }

  Future<String?> getUserAvatar(String avatarUrl) async {
    if (avatarUrl != "") {
      Dio dio = getIt<Dio>();
      Response response = await dio.get(avatarUrl);
      if (response.statusCode == 200) {
        String base64 = response.data;

        Uint8List bytes = base64Decode(base64);
        String base64String = base64Encode(bytes);
        return base64String;
      }
    }
    return null;
  }
}
