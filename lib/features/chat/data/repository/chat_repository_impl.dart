import 'package:dawaa24/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:dawaa24/features/chat/data/remote_datasource/chat_remote_datasource.dart';
import 'package:dawaa24/features/chat/domain/repository/chat_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  ChatRepositoryImpl(
    this.remoteDataSource, this.authLocalDataSource,
  );

  @override
  Future<String> getChatToken() async {
    final res = await remoteDataSource.getChatToken();
    return res.data!;
  }

  @override
  Future<String> getUserId() async {
    return await authLocalDataSource.getAgoraUserId() ?? '';
  }

  Future<String> getSuffix() async {
   var temp = await authLocalDataSource.getUserInfo();
   return temp.suffix ??'';
  }

}
