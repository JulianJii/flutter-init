import 'package:flutter_init/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_init/features/survey/domain/entities/survey_entity.dart';
import 'package:flutter_init/features/survey/domain/repositories/survey_repository.dart';

class SubmitSurveyUseCase {
  final SurveyRepository _repository;

  SubmitSurveyUseCase(this._repository);

  Future<Either<Failure, void>> call(SurveyEntity survey) {
    return _repository.submitSurvey(survey);
  }
}
