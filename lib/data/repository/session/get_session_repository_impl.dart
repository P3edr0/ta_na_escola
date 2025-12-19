import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/exceptions/auth_exceptions.dart';

import '../../../domain/entities/session_entity.dart';
import '../../../domain/repository/session/session_repository.dart';
import '../../base_datasource/session/get_session.dart';

class GetSessionRepositoryImpl implements IGetSessionRepository {
  GetSessionRepositoryImpl({required this.datasource});
  IGetSessionDatasource datasource;
  @override
  Future<Either<ITneExceptions, SessionEntity?>> call() async {
    final response = await datasource.call();
    return response;
  }
}
