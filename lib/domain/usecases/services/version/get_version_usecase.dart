import 'package:dartz/dartz.dart';

import '../../../entities/version_entity.dart';
import '../../../exceptions/auth_exceptions.dart';
import '../../../repository/services/version_repository.dart';

class GetVersionUsecase {
  GetVersionUsecase({required this.repository});
  IGetVersionRepository repository;
  Future<Either<ITneExceptions, VersionEntity>> call() async {
    return await repository();
  }
}
