import 'package:dartz/dartz.dart';

import '../../../domain/entities/session_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';

abstract class IGetSessionDatasource {
  Future<Either<ITneExceptions, SessionEntity?>> call();
}
