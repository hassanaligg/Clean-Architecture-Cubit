import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../features/auth/domain/usecase/get_user_info_usecase.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  await getIt.init();
}

Future<void> resetInjection() async {
  await getIt.reset();
}
