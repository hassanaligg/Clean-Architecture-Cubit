import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/core/utils/constants.dart';
import 'package:dawaa24/features/chat/data/remote_datasource/chat_remote_datasource.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/datasource/base_remote_datasource.dart';

@Singleton(as: ChatRemoteDataSource)
class ChatDataSourceImpl extends BaseRemoteDataSourceImpl
    implements ChatRemoteDataSource {
  String getChatTokenEndPoint =
      '${AppConstant.baseUrl}/api/app/agora/BuildMobileUserToken';

  ChatDataSourceImpl({required super.dio});

  @override
  Future<BaseResponse<String>> getChatToken() async {
    final res = await post(
        url: getChatTokenEndPoint,
        decoder: (json) {
          return json.toString();
        },
        requiredToken: true);

    return res;
  }
}
