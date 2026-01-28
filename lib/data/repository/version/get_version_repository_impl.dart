import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/version_entity.dart';
import 'package:ta_na_escola/domain/exceptions/auth_exceptions.dart';

import '../../../domain/repository/services/version_repository.dart';
import '../../base_datasource/services/get_version.dart';

class GetVersionRepositoryImpl implements IGetVersionRepository {
  GetVersionRepositoryImpl({required this.datasource});
  IGetVersionDatasource datasource;
  @override
  Future<Either<ITneExceptions, VersionEntity>> call() async {
    final response = await datasource.call();
    return response;
  }
}
