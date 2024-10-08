

abstract class ChatRepository {
  Future<String> getChatToken();
  Future<String> getUserId();
  Future<String> getSuffix();
}
