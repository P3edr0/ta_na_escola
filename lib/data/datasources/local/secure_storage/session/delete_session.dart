import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../domain/exceptions/auth_exceptions.dart';
import '../../../../base_datasource/session/delete_session.dart';

class SecureStorageDeleteSession implements IDeleteSessionDatasource {
  @override
  Future<Either<ITneExceptions, bool>> call() async {
    const storage = FlutterSecureStorage();
    try {
      await storage.deleteAll();

      return const Right(true);
    } catch (e) {
      log(e.toString());
      return Left(BadRequestJackException(message: "Falha ao fazer logout"));
    }
  }
}
