import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/chat/domain/repository/chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSuffixUseCase extends UseCase<String, NoParams> {
  final ChatRepository repository;

  GetSuffixUseCase({required this.repository});

  @override
  Future<String> call(params) async {
    return repository.getSuffix();
  }
}
