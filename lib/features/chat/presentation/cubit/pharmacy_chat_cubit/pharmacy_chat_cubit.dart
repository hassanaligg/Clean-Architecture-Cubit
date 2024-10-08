import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/core/services/agora_service.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/core/utils/failures/base_failure.dart';
import 'package:dawaa24/di/injection.dart';
import 'package:dawaa24/features/chat/data/model/chat_list_model.dart';
import 'package:dawaa24/features/chat/data/model/message_model.dart' as model
    hide MessageType;
import 'package:dawaa24/features/chat/domain/usecase/get_user_id_usecase.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/data/network/network_Info.dart';
import '../../../domain/usecase/get_chat_token_usecase.dart';
import '../../../domain/usecase/get_suffix_usecase.dart';

part 'pharmacy_chat_state.dart';

class PharmacyChatCubit extends Cubit<PharmacyChatState> {
  final String? targetId;

  PharmacyChatCubit({this.targetId}) : super(PharmacyChatState.initial()) {
    _chatTokenUseCase = getIt<GetChatTokenUseCase>();
    _getUserIdUseCase = getIt<GetUserIdUseCase>();
    _getSuffixUseCase = getIt<GetSuffixUseCase>();
    _agoraService = getIt<AgoraService>();
    networkInfoImpl = getIt<NetworkInfo>();
    initFunction();
  }

  late GetChatTokenUseCase _chatTokenUseCase;
  late GetUserIdUseCase _getUserIdUseCase;
  late GetSuffixUseCase _getSuffixUseCase;
  late AgoraService _agoraService;
  late NetworkInfo networkInfoImpl;

  getChatToken() async {
    try {
      var token = await _chatTokenUseCase(NoParams());
      var userIdTemp = await _getUserIdUseCase(NoParams());
      emit(state.copyWith(agoraToken: token, userId: userIdTemp));
    } on Failure catch (_) {
      rethrow;
    }
  }

  saveTargetId() async {
    try {
      var suffixSTR = await _getSuffixUseCase(NoParams());
      if (targetId!.contains(suffixSTR)) {
        emit(state.copyWith(targetId: targetId!));
      } else {
        emit(state.copyWith(targetId: targetId! + suffixSTR));
      }
    } on Failure catch (l) {
      emit(state.copyWith(failure: l, status: PharmacyChatStatus.error));
    }
  }

  Future initFunction() async {
    emit(state.changeState(PharmacyChatStatus.loading));
    try {
      if (targetId != null) {
        await saveTargetId();
      }

      await getChatToken();
      if (targetId != null) {
        checkStatus();
      }
      await addChatListener();
      if (targetId != null) {
        await getHistoric();
      } else {
        await getHistoricChats();
      }
      emit(state.changeState(PharmacyChatStatus.success));
    } on Failure catch (l) {
      emit(state.copyWith(failure: l, status: PharmacyChatStatus.error));
    } catch (e) {
      if (e.toString().contains("201")) {
        _agoraService.signIn();
        await initFunction();
      } else if (getIt<AgoraService>().chatClient == null) {
        getIt<AgoraService>().initSDK();
      }
    }
  }

  addChatListener() {
    state.chatClient.chatManager.addMessageEvent(
        state.targetId,
        ChatMessageEvent(
          onSuccess: (msgId, msg) {
            if (msg.body is ChatTextMessageBody) {
              ChatTextMessageBody body = msg.body as ChatTextMessageBody;
              emit(state.addMessageToList(model.MessageModel(
                  id: msgId,
                  message: body.content.toString(),
                  isSender: false,
                  isDelivery: msg.hasDeliverAck,
                  isRead: msg.hasReadAck,
                  createTime:
                      DateTime.now().toString().split(".").first.toString())));
            } else if (msg.body is ChatImageMessageBody) {
              emit(state.copyWith(isUploading: false));
              emit(state.addMessageToList(model.MessageModel(
                  id: msgId,
                  message: "",
                  isImage: true,
                  isDelivery: msg.hasDeliverAck,
                  isRead: msg.hasReadAck,
                  imagePath: (msg.body as ChatImageMessageBody).remotePath,
                  isSender: false,
                  messageType: MessageType.IMAGE,
                  createTime:
                      DateTime.now().toString().split(".").first.toString())));
            } else if (msg.body is ChatFileMessageBody) {
              emit(state.copyWith(isUploading: false));
              emit(state.addMessageToList(model.MessageModel(
                  id: msg.msgId,
                  messageType: MessageType.FILE,
                  filePath: (msg.body as ChatFileMessageBody).remotePath,
                  fileName: (msg.body as ChatFileMessageBody).displayName,
                  isFile: true,
                  message: "",
                  isDelivery: msg.hasDeliverAck,
                  isRead: msg.hasReadAck,
                  isSender: ((msg.from ?? '') != state.userId),
                  createTime: msg.serverTime.toReadableDate())));
            }
          },
          onProgress: (msgId, progress) {
            log("send message succeed");
          },
          onError: (msgId, msg, error) {
            emit(state.copyWith(isUploading: false));
            "failures.some_thing_wrong"
                .tr()
                .showToast(toastGravity: ToastGravity.CENTER);
            log(
              "send message failed, code: ${error.code}, desc: ${error.description}",
            );
          },
        ));
    state.chatClient.chatManager.addEventHandler(
      state.targetId,
      ChatEventHandler(onMessagesReceived: onMessagesReceived),
    );
  }

  getHistoric() async {
    ChatCursorResult<ChatMessage> chat = await state.chatClient.chatManager
        .fetchHistoryMessages(
            conversationId: state.targetId, pageSize: state.pageSize);
    List<model.MessageModel> tempList = [];
    for (var element in chat.data) {
      if (element.body is ChatTextMessageBody) {
        // state.chatClient.chatManager,
        tempList.add(model.MessageModel(
            id: element.msgId,
            message: (element.body as ChatTextMessageBody).content,
            isSender: ((element.from ?? '') != state.userId),
            isDelivery: element.hasDeliverAck,
            isRead: element.hasRead,
            createTime: element.serverTime.toReadableDate()));
      } else if (element.body is ChatImageMessageBody) {
        tempList.add(model.MessageModel(
            id: element.msgId,
            messageType: MessageType.IMAGE,
            imagePath: (element.body as ChatImageMessageBody).remotePath,
            isImage: true,
            message: "",
            isDelivery: element.hasDeliverAck,
            isRead: element.hasReadAck,
            fileName: (element.body as ChatImageMessageBody).remotePath,
            isSender: ((element.from ?? '') != state.userId),
            createTime: element.serverTime.toReadableDate()));
      } else if (element.body is ChatFileMessageBody) {
        tempList.add(model.MessageModel(
            id: element.msgId,
            messageType: MessageType.FILE,
            filePath: (element.body as ChatFileMessageBody).remotePath,
            fileName: (element.body as ChatFileMessageBody).displayName,
            isFile: true,
            message: "",
            isDelivery: element.hasDeliverAck,
            isRead: element.hasReadAck,
            isSender: ((element.from ?? '') != state.userId),
            createTime: element.serverTime.toReadableDate()));
      }
    }
    emit(state.copyWith(logText: tempList));
  }

  getHistoricChats({bool withLoading = true}) async {
    if (withLoading) {
      emit(state.copyWith(status: PharmacyChatStatus.loading));
    }
    ChatCursorResult<ChatConversation> allConversations = await state
        .chatClient.chatManager
        .fetchConversation(pageSize: 1000, cursor: "");

    List<ChatListModel> chats =
        await Future.wait(allConversations.data.map((element) async {
      ChatMessage? latestMessage = await element.latestMessage();
      int? unreadCount = await element.unreadCount();
      Map<String, ChatUserInfo> userInfoMap = await state
          .chatClient.userInfoManager
          .fetchUserInfoById([element.id], expireTime: 0);

      return ChatListModel.fromChatConversation(element,
          userInfoMap[element.id], latestMessage, unreadCount, element.id);
    }).toList());

    emit(state.copyWith(
        status: PharmacyChatStatus.success, allConversation: chats));
  }

  Future<Map<String, ChatUserInfo>> getUserInfo(id) async {
    Map<String, ChatUserInfo> userInfo =
        await state.chatClient.userInfoManager.fetchUserInfoById([id]);
    return userInfo;
  }

  Future<bool> sendMessage(String? messageContent) async {
    if (!await checkInternet()) {
      return false;
    }

    if (messageContent == null) {
      return false;
    }
    state.textEditingController.clear();
    emit(state);
    var msg = ChatMessage.createTxtSendMessage(
      targetId: state.targetId,
      content: messageContent,
    );
    try {
      state.chatClient.chatManager.sendMessage(msg);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> uploadImage(String? filePath) async {
    if (!await checkInternet()) {
      return false;
    }
    if (filePath == null) {
      return false;
    }
    emit(state.copyWith(isUploading: true));
    var msg = ChatMessage.createImageSendMessage(
      targetId: state.targetId,
      filePath: filePath,
    );
    try {
      await state.chatClient.chatManager.sendMessage(msg);

      imageModeView(null, false);
      return true;
    } catch (e) {
      emit(state.copyWith(isUploading: false));
      return false;
    }
  }

  Future<bool> uploadFile(String? filePath) async {
    if (!await checkInternet()) {
      return false;
    }
    if (filePath == null) {
      log("single chat id or message content is null");
      return false;
    }
    emit(state.copyWith(isUploading: true));
    ChatMessage message = ChatMessage.createFileSendMessage(
      targetId: state.targetId,
      filePath: filePath,
    );
    try {
      await state.chatClient.chatManager.sendMessage(message).then((value) {
        var res = value;
        print(value);
      });
      return true;
    } catch (e) {
      emit(state.copyWith(isUploading: false));
      return false;
    }
  }

  void onMessagesReceived(List<ChatMessage> messages) {
    getHistoricChats();
    for (var msg in messages) {
      if (msg.to == state.targetId || msg.from == state.targetId) {
        switch (msg.body.type) {
          case MessageType.TXT:
            {
              ChatTextMessageBody body = msg.body as ChatTextMessageBody;
              List<model.MessageModel> temp = List.from(state.logText);
              temp.add(model.MessageModel(
                id: msg.msgId,
                message: body.content,
                isDelivery: msg.hasDeliverAck,
                isRead: msg.hasReadAck,
                isSender: ((msg.from ?? '') != state.userId),
                createTime: msg.serverTime.toReadableDate(),
              ));

              emit(state.copyWith(logText: temp));
            }
            break;
          case MessageType.IMAGE:
            List<model.MessageModel> temp = List.from(state.logText);
            temp.add(model.MessageModel(
                id: msg.msgId,
                messageType: MessageType.IMAGE,
                imagePath: (msg.body as ChatImageMessageBody).remotePath,
                isImage: true,
                message: "",
                isDelivery: msg.hasDeliverAck,
                isRead: msg.hasReadAck,
                isSender: ((msg.from ?? '') != state.userId),
                createTime: msg.serverTime.toReadableDate()));

            emit(state.copyWith(logText: temp));
            break;

          case MessageType.VIDEO:
            {
              log(
                "receive video message, from: ${msg.from}",
              );
            }
            break;
          case MessageType.LOCATION:
            {
              log(
                "receive location message, from: ${msg.from}",
              );
            }
            break;
          case MessageType.VOICE:
            {
              log(
                "receive voice message, from: ${msg.from}",
              );
            }
            break;
          case MessageType.FILE:
            {
              List<model.MessageModel> temp = List.from(state.logText);
              temp.add(model.MessageModel(
                  id: msg.msgId,
                  messageType: MessageType.FILE,
                  filePath: (msg.body as ChatFileMessageBody).remotePath,
                  fileName: (msg.body as ChatFileMessageBody).displayName,
                  isFile: true,
                  message: "",
                  isDelivery: msg.hasDeliverAck,
                  isRead: msg.hasReadAck,
                  isSender: ((msg.from ?? '') != state.userId),
                  createTime: msg.serverTime.toReadableDate()));
              emit(state.copyWith(logText: temp));
            }
            break;
          case MessageType.CUSTOM:
            {
              log(
                "receive custom message, from: ${msg.from}",
              );
            }
            break;
          case MessageType.CMD:
            {
              // Receiving command messages does not trigger the `onMessagesReceived` event, but triggers the `onCmdMessagesReceived` event instead.
            }
            break;
          case MessageType.COMBINE:
            {
              log(
                "receive custom message, from: ${msg.from}",
              );
            }
            break;
        }
      }
    }
    emit(state.copyWith(status: PharmacyChatStatus.success));
  }

  void loadMoreMessages() async {
    emit(state.copyWith(getMoreLoading: true, pageSize: 10 + state.pageSize));
    await getHistoric();
    emit(state.copyWith(getMoreLoading: false));
  }

  imageModeView(File? image, bool enable, {bool isCamera = false}) {
    if (isCamera) {
      uploadImage(image!.path);
    } else {
      enable
          ? emit(state.copyWith(image: image))
          : emit(state.copyWith(image: null));
    }
  }

  @override
  Future<void> close() {
    state.chatClient.chatManager.removeMessageEvent(state.targetId);
    state.chatClient.chatManager.removeEventHandler(state.targetId);
    return super.close();
  }

  void checkStatus() async {
    ChatPresence? chatPresence =
        await _agoraService.queryPeerOnlineStatus(state.targetId);
    var status =
        chatPresence == null ? "Offline" : chatPresence.statusDescription;
    var time = chatPresence!.lastTime.toReadableDate();
    emit(state.copyWith(
        isOnline: (status == "Offline" || status.isEmpty) ? false : true));
    emit(state.copyWith(lastSeen: time));
    // emit(state.copyWith(lastSeen: 1641031200000.toReadableDate()));
  }

  String getLastSeen(BuildContext context) {
    try {
      if (state.lastSeen != null) {
        var date = formatLastSeen(DateTime.parse(state.lastSeen!), context);
        return date.toString();
      }
      return "";
    } catch (e) {
      return "chat.offline".tr();
    }
  }

  void searchChat(String searchKey) {
    if (searchKey.isEmpty) {
      emit(state.copyWith(filteredConversation: state.allConversation));
    } else {
      searchKey = searchKey.toLowerCase();
      List<ChatListModel> filteredList =
          state.allConversation!.where((element) {
        final nickname = element.userInfo?.nickName?.toLowerCase() ?? '';
        final phone = element.userInfo?.phone?.toLowerCase() ?? '';
        return nickname.contains(searchKey) || phone.contains(searchKey);
      }).toList();
      emit(state.copyWith(filteredConversation: filteredList));
    }
  }

  String formatLastSeen(DateTime dateTime, BuildContext context) {
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final dateToCheck = DateTime(dateTime.day, dateTime.month, dateTime.day);

      String formattedTime =
          DateFormat('h:mm a', context.isArabic ? "ar" : "en").format(
        dateTime,
      );

      if (dateToCheck == today) {
        return '${'chat.last_seen_today_at'.tr()} $formattedTime';
      } else if (dateToCheck == today.subtract(const Duration(days: 1))) {
        return '${'chat.last_seen_yesterday_at'.tr()} $formattedTime';
      } else {
        String formattedDate =
            DateFormat('dd MMM', context.isArabic ? "ar" : "en")
                .format(dateTime);
        return '${'chat.last_seen_on'.tr()} $formattedDate ${'chat.at'.tr()} $formattedTime';
      }
    } catch (e) {
      return "chat.offline".tr();
    }
  }

  Future<void> makeConversationRead(String conversationId) async {
    ChatConversation? conversation =
        await state.chatClient.chatManager.getConversation(conversationId);
    await conversation!.markAllMessagesAsRead();
  }

  Future<bool> checkInternet() async {
    if (await networkInfoImpl.isConnected) {
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "failures.no_internet".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.sp);
    }
    return false;
  }

  checkMaxFiledLength() {
    if (state.textEditingController.text.length >= 1000) {
      emit(state.copyWith(maxFiledLength: true));
    } else {
      emit(state.copyWith(maxFiledLength: false));
    }
  }

  Future<String?> getUserAvatar(String avatarUrl) async {
    try {
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
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  getUserProfile(String avtarUrl) async {
    var avatarUrl = await getUserAvatar(avtarUrl);
    emit(state.copyWith(userAvtarUrl: avatarUrl));
  }
}
