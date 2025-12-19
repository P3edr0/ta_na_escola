import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/exceptions/auth_exceptions.dart';

import '../../../domain/entities/session_entity.dart';

abstract class ICreateSessionDatasource {
  Future<Either<ITneExceptions, bool>> call(SessionEntity session);
}
