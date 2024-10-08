
import '../../../../../core/data/model/base_response_model.dart';

abstract class ChatRemoteDataSource {
  Future<BaseResponse<String>> getChatToken();
}
