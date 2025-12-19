import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/exceptions/auth_exceptions.dart';

import '../../entities/session_entity.dart';

abstract class ICreateSessionRepository {
  Future<Either<ITneExceptions, bool>> call(SessionEntity session);
}

abstract class IGetSessionRepository {
  Future<Either<ITneExceptions, SessionEntity?>> call();
}

abstract class IDeleteSessionRepository {
  Future<Either<ITneExceptions, bool>> call();
}
