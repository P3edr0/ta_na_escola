import 'package:dartz/dartz.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';

abstract class ILoginDatasource {
  Future<Either<ITneExceptions, UserEntity>> call(
    String credential,
    String password,
    String? notifyToken,
  );
}
