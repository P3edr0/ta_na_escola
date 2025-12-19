import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../domain/entities/session_entity.dart';
import '../../../../../domain/exceptions/auth_exceptions.dart';
import '../../../../base_datasource/session/create_session.dart';

class SecureStorageCreateSession implements ICreateSessionDatasource {
  @override
  Future<Either<ITneExceptions, bool>> call(SessionEntity session) async {
    const storage = FlutterSecureStorage();
    const key = 'login';
    try {
      await storage.delete(key: key);
      await storage.write(key: key, value: session.toString());
      return const Right(true);
    } catch (e) {
      log(e.toString());
      return Left(BadRequestJackException());
    }
  }
}
