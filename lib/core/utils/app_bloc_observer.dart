import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  late Logger logger;

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.i('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    logger.i('${bloc.runtimeType} CLOSED');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    logger.i('${bloc.runtimeType} CREATED');
    super.onCreate(bloc);
  }

  AppBlocObserver()
      : logger = Logger(
          printer: PrettyPrinter(colors: false, isStackTraceEnabled: false),
        );
}

class MyPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return [event.message];
  }
}
