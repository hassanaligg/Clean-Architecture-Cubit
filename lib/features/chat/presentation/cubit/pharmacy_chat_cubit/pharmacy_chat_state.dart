part of 'pharmacy_chat_cubit.dart';

enum PharmacyChatStatus { initial, loading, error, errorClose, success }

class PharmacyChatState {
  final PharmacyChatStatus status;
  final Failure? failure;
  final ChatClient chatClient;
  final String userId;
  final String targetId;
  final String? file;
  final String? lastSeen;
  final List<model.MessageModel> logText;
  List<ChatListModel>? allConversation;
  List<ChatListModel>? filteredConversation;
  final TextEditingController textEditingController;
  bool? getMoreLoading;
  bool? isUploading;
  bool? isOnline;
  int pageSize;
  File? image;
  bool? maxFiledLength;
  String userAvtarUrl;

  PharmacyChatState._(
      {required this.status,
      this.failure,
      required this.userId,
      required this.targetId,
      required this.chatClient,
      required this.userAvtarUrl,
      required this.textEditingController,
      this.getMoreLoading,
      this.isUploading,
      this.lastSeen,
      this.allConversation,
      this.filteredConversation,
      this.isOnline,
      required this.pageSize,
      this.image,
      this.file,
      this.maxFiledLength,
      required this.logText});

  PharmacyChatState.initial()
      : status = PharmacyChatStatus.initial,
        chatClient = getIt<AgoraService>().chatClient,
        userId = '',
        targetId = '',
        lastSeen = '',
        userAvtarUrl = '',
        logText = [],
        allConversation = [],
        filteredConversation = [],
        textEditingController = TextEditingController(),
        getMoreLoading = false,
        isUploading = false,
        isOnline = false,
        pageSize = 20,
        image = null,
        file = null,
        maxFiledLength = false,
        failure = null;

  PharmacyChatState changeState(PharmacyChatStatus status) {
    return copyWith(status: status);
  }

  PharmacyChatState addMessageToList(model.MessageModel message) {
    print("addMessageToList ${message.message}");
    var tempList = logText;
    tempList.add(message);
    return copyWith(logText: tempList);
  }

  copyWith(
      {PharmacyChatStatus? status,
      Failure? failure,
      List<model.MessageModel>? logText,
      String? agoraToken,
      String? userId,
      String? file,
      String? lastSeen,
      String? userAvtarUrl,
      TextEditingController? textEditingController,
      bool? getMoreLoading,
      bool? isUploading,
      bool? isOnline,
      int? pageSize,
      File? image,
      bool? maxFiledLength,
      List<ChatListModel>? allConversation,
      List<ChatListModel>? filteredConversation,
      String? targetId}) {
    return PharmacyChatState._(
        status: status ?? this.status,
        logText: logText ?? this.logText,
        chatClient: chatClient,
        userId: userId ?? this.userId,
        targetId: targetId ?? this.targetId,
        lastSeen: lastSeen ?? this.lastSeen,
        allConversation: allConversation ?? this.allConversation,
        filteredConversation: filteredConversation ?? this.filteredConversation,
        getMoreLoading: getMoreLoading ?? this.getMoreLoading,
        isOnline: isOnline ?? this.isOnline,
        textEditingController:
            textEditingController ?? this.textEditingController,
        failure: failure ?? this.failure,
        pageSize: pageSize ?? this.pageSize,
        isUploading: isUploading ?? this.isUploading,
        file: file,
        maxFiledLength: maxFiledLength ?? this.maxFiledLength,
        userAvtarUrl: userAvtarUrl ?? this.userAvtarUrl,
        image: image);
  }
}
