import 'package:dartz/dartz.dart';

import '../../../domain/exceptions/auth_exceptions.dart';

abstract class ICreatePasswordDatasource {
  Future<Either<ITneExceptions, bool>> call(
    String password,
    String createPasswordToken,
  );
}
