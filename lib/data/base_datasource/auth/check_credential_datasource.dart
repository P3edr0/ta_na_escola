import 'package:dartz/dartz.dart';

import '../../../domain/entities/check_credential_response_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';

abstract class ICheckCredentialDatasource {
  Future<Either<ITneExceptions, CheckCredentialResponseEntity>> call(
    String credential,
  );
}
