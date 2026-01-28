import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/version_entity.dart';

import '../../exceptions/auth_exceptions.dart';

abstract class IGetVersionRepository {
  Future<Either<ITneExceptions, VersionEntity>> call();
}
