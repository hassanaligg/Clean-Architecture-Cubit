import '../base_failure.dart';


abstract class LocalStorageFailure extends Failure{
   LocalStorageFailure();
}

class DataNotExistFailure extends LocalStorageFailure{
   DataNotExistFailure();
}

class BadDataFailure extends LocalStorageFailure{
   BadDataFailure();
}