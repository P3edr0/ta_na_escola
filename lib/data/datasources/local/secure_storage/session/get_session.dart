import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../domain/entities/session_entity.dart';
import '../../../../../domain/exceptions/auth_exceptions.dart';
import '../../../../base_datasource/session/get_session.dart';
import '../../../../mapper/session_mapper.dart';

class SecureStorageGetSession implements IGetSessionDatasource {
  @override
  Future<Either<ITneExceptions, SessionEntity?>> call() async {
    const storage = FlutterSecureStorage();
    const key = 'login';
    try {
      String? response = await storage.read(key: key);
      if (response == null) {
        return const Right(null);
      }

      final newResponse = response
          .replaceAll(RegExp(r'\"\{'), "'{")
          .replaceAll(RegExp(r'\}\"'), "}'");
      final content = jsonDecode(newResponse);
      log(content.toString());
      final session = SessionMapper.fromJson(content);

      return Right(session);
    } catch (e) {
      log(e.toString());
      return Left(BadRequestJackException());
    }
  }
}
