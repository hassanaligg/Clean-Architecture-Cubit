import 'dart:developer';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:dawaa24/core/utils/constants.dart';
import 'package:injectable/injectable.dart';

import '../../di/injection.dart';
import '../../features/chat/domain/usecase/get_chat_token_usecase.dart';
import '../../features/chat/domain/usecase/get_user_id_usecase.dart';
import '../domain/usecase/usecase.dart';
import '../utils/failures/base_failure.dart';
import '../utils/failures/http/http_failure.dart';

@singleton
class AgoraService {
  late ChatClient chatClient;
  late GetChatTokenUseCase _chatTokenUseCase;
  late GetUserIdUseCase _getUserIdUseCase;
  String agoraToken = "";
  String userId = "";

  Future<void> initSDK() async {
    _chatTokenUseCase = getIt<GetChatTokenUseCase>();
    _getUserIdUseCase = getIt<GetUserIdUseCase>();
    ChatOptions options = ChatOptions(
      appKey: AgoraChatConfigConstant.appKey,
      autoLogin: false,
    );

    chatClient = ChatClient.getInstance..init(options);
    await chatClient.startCallback();
    await getChatToken();
    if (await chatClient.isConnected() == false) {
      await signIn();
    }
  }

  Future<bool> signIn() async {
    try {
      await chatClient.loginWithAgoraToken(
        userId,
        agoraToken,
      );
      return true;
    } on ChatError catch (e) {
      throw CustomFailure(message: e.description);
    }
  }

  Future<bool> signOut() async {
    try {
      await chatClient.logout(true);
      return true;
    } on ChatError catch (e) {
      return false;
    }
  }

  Future<void> getChatToken() async {
    try {
      agoraToken = await _chatTokenUseCase(NoParams());
      userId = await _getUserIdUseCase(NoParams());
    } on Failure catch (e) {
      log("getChatToken error:${e.toString()}");
    }
  }

  Future<ChatPresence?> queryPeerOnlineStatus(String targetId) async {
    try {
      List<ChatPresence> list = await ChatClient.getInstance.presenceManager
          .fetchPresenceStatus(members: [targetId]);
      return list.first;
    } on ChatError catch (e) {
      return null;
    }
  }
  Future<String> getLastSeen(String targetId) async {
    try {
      List<ChatPresence> list = await ChatClient.getInstance.presenceManager
          .fetchPresenceStatus(members: [targetId]);
      return list.first.statusDescription;
    } on ChatError catch (e) {
      return "offline";
    }
  }
}