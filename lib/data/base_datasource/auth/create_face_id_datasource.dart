import 'package:dartz/dartz.dart';

import '../../../domain/exceptions/auth_exceptions.dart';

abstract class ICreateFaceIdDatasource {
  Future<Either<ITneExceptions, bool>> call(String image, String token);
}
