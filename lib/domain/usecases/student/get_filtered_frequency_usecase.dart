import 'package:dartz/dartz.dart';
import 'package:ta_na_escola/domain/entities/frequency_entity.dart';

import '../../entities/data_frequency_entity.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repository/student/student_repository.dart';

class GetFilteredFrequencyUsecase {
  GetFilteredFrequencyUsecase({required this.repository});
  IGetFilteredFrequencyRepository repository;
  Future<Either<ITneExceptions, List<FrequencyEntity>>> call({
    required DataFrequencyEntity data,
  }) async {
    if (data.schoolId.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.studentId.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.token.trim().isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.pages.isEmpty) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.finalFilterDate == null) {
      return Left(DataException(message: 'Dados inválido.'));
    }
    if (data.startFilterDate == null) {
      return Left(DataException(message: 'Dados inválido.'));
    }

    return await repository(data);
  }
}
