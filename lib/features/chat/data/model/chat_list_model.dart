import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:dawaa24/core/utils/extentions.dart';

class ChatListModel {
  final String id;
  final ChatConversationType type;
  final bool isChatThread;
  final bool isPinned;
  final int pinnedTime;
  final int? unreadMessage;
  final ChatUserInfo? userInfo;
  final ChatMessage? lastMessage;
  final String? conversationId;

  ChatListModel({
    required this.id,
    required this.type,
    required this.isChatThread,
    required this.isPinned,
    required this.pinnedTime,
    this.userInfo,
    this.lastMessage,
    this.unreadMessage,
    this.conversationId,
  });

  factory ChatListModel.fromChatConversation(
      ChatConversation conversation,
      ChatUserInfo? userInfo,
      ChatMessage? lastMessage,
      int? unreadMessage,
      String? conversationId) {
    return ChatListModel(
        id: conversation.id,
        type: conversation.type,
        isChatThread: conversation.isChatThread,
        isPinned: conversation.isPinned,
        pinnedTime: conversation.pinnedTime,
        userInfo: userInfo,
        lastMessage: lastMessage,
        conversationId: conversationId ?? "",
        unreadMessage: unreadMessage ?? 0);
  }

  DateTime get timestamp {
    String convertedCreateTime = convertArabicIndicToArabicNumerals(
        lastMessage!.serverTime.toReadableDate());
    return DateTime.parse(convertedCreateTime);
  }

  String convertArabicIndicToArabicNumerals(String input) {
    const arabicIndicDigits = '٠١٢٣٤٥٦٧٨٩';
    const arabicDigits = '0123456789';
    for (int i = 0; i < arabicIndicDigits.length; i++) {
      input = input.replaceAll(arabicIndicDigits[i], arabicDigits[i]);
    }
    return input;
  }
}
