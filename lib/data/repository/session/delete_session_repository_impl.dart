import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/exceptions/auth_exceptions.dart';

import '../../../domain/repository/session/session_repository.dart';
import '../../base_datasource/session/delete_session.dart';

class DeleteSessionRepositoryImpl implements IDeleteSessionRepository {
  DeleteSessionRepositoryImpl({required this.datasource});
  IDeleteSessionDatasource datasource;
  @override
  Future<Either<ITneExceptions, bool>> call() async {
    final response = await datasource.call();
    return response;
  }
}
