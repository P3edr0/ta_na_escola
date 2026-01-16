import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/data_frequency_entity.dart';
import 'package:ta_na_escola/domain/entities/frequency_entity.dart';
import 'package:ta_na_escola/domain/entities/student_entity.dart';

import '../../../domain/exceptions/auth_exceptions.dart';

abstract class IFetchStudentDatasource {
  Future<Either<ITneExceptions, List<StudentEntity>>> call(String token);
}

abstract class IGetFrequencyDatasource {
  Future<Either<ITneExceptions, List<FrequencyEntity>>> call(
    DataFrequencyEntity data,
  );
}

abstract class IGetFilteredFrequencyDatasource {
  Future<Either<ITneExceptions, List<FrequencyEntity>>> call(
    DataFrequencyEntity data,
  );
}
