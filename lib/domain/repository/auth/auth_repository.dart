import 'package:dartz/dartz.dart';

import '../../entities/check_credential_response_entity.dart';
import '../../entities/user_entity.dart';
import '../../exceptions/auth_exceptions.dart';

abstract class ILoginRepository {
  Future<Either<ITneExceptions, UserEntity>> call(
    String credential,
    String password,
    String? notifyToken,
  );
}

abstract class ICheckCredentialRepository {
  Future<Either<ITneExceptions, CheckCredentialResponseEntity>> call(
    String credential,
  );
}

abstract class IRecoverPasswordRepository {
  Future<Either<ITneExceptions, String>> call(String credential);
}

abstract class ICreatePasswordRepository {
  Future<Either<ITneExceptions, bool>> call(
    String password,
    String createPasswordToken,
  );
}

abstract class ICreateFaceIdRepository {
  Future<Either<ITneExceptions, bool>> call(String image, String token);
}
