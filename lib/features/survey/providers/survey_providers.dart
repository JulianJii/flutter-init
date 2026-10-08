import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/survey_remote_data_source.dart';
import '../data/repositories/survey_repository_impl.dart';
import '../domain/repositories/survey_repository.dart';
import '../domain/usecases/check_username_use_case.dart';
import '../domain/usecases/submit_survey_use_case.dart';

part 'survey_providers.g.dart';

/// 数据层依赖注入 providers
/// 这些 providers 负责创建和管理数据层实例

// --- 数据源 ---
@Riverpod(keepAlive: true)
SurveyRemoteDataSource surveyRemoteDataSource(Ref ref) {
  return SurveyRemoteDataSourceImpl();
}

// --- 仓库 ---
@Riverpod(keepAlive: true)
SurveyRepository surveyRepository(Ref ref) {
  return SurveyRepositoryImpl(ref.watch(surveyRemoteDataSourceProvider));
}

// --- 用例 ---
@Riverpod(keepAlive: true)
SubmitSurveyUseCase submitSurveyUseCase(Ref ref) {
  return SubmitSurveyUseCase(ref.watch(surveyRepositoryProvider));
}

@Riverpod(keepAlive: true)
CheckUsernameUseCase checkUsernameUseCase(Ref ref) {
  return CheckUsernameUseCase(ref.watch(surveyRepositoryProvider));
}
