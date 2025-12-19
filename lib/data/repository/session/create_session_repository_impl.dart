import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/exceptions/auth_exceptions.dart';

import '../../../domain/entities/session_entity.dart';
import '../../../domain/repository/session/session_repository.dart';
import '../../base_datasource/session/create_session.dart';

class CreateSessionRepositoryImpl implements ICreateSessionRepository {
  CreateSessionRepositoryImpl({required this.datasource});
  ICreateSessionDatasource datasource;
  @override
  Future<Either<ITneExceptions, bool>> call(SessionEntity session) async {
    final response = await datasource.call(session);
    return response;
  }
}
