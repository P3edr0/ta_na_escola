import 'package:dartz/dartz.dart';

import '../../../domain/entities/version_entity.dart';
import '../../../domain/exceptions/auth_exceptions.dart';

abstract class IGetVersionDatasource {
  Future<Either<ITneExceptions, VersionEntity>> call();
}
