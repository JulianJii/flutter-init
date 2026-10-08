import 'package:init/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/survey_entity.dart';
import '../repositories/survey_repository.dart';

class SubmitSurveyUseCase {
  final SurveyRepository _repository;

  SubmitSurveyUseCase(this._repository);

  Future<Either<Failure, void>> call(SurveyEntity survey) {
    return _repository.submitSurvey(survey);
  }
}
