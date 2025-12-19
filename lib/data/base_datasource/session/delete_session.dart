import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../domain/exceptions/auth_exceptions.dart';

abstract class IDeleteSessionDatasource {
  Future<Either<ITneExceptions, bool>> call();
}
