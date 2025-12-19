import 'package:dartz/dartz.dart';

import '../../../domain/exceptions/auth_exceptions.dart';

abstract class IRecoverPasswordDatasource {
  Future<Either<ITneExceptions, String>> call(String credential);
}
