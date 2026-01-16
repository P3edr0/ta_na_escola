import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/frequency_entity.dart';
import 'package:ta_na_escola/domain/entities/student_entity.dart';

import '../../entities/data_frequency_entity.dart';
import '../../exceptions/auth_exceptions.dart';

abstract class IFetchStudentRepository {
  Future<Either<ITneExceptions, List<StudentEntity>>> call(String token);
}

abstract class IGetFrequencyRepository {
  Future<Either<ITneExceptions, List<FrequencyEntity>>> call(
    DataFrequencyEntity data,
  );
}

abstract class IGetFilteredFrequencyRepository {
  Future<Either<ITneExceptions, List<FrequencyEntity>>> call(
    DataFrequencyEntity data,
  );
}
