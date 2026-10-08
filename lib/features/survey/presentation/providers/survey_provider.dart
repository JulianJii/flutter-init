import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/survey_entity.dart';
import '../../providers/survey_providers.dart';

part 'survey_provider.g.dart';

/// 表现层状态管理
/// 本文件只包含与 UI 相关的 state providers

// --- 状态管理 ---
enum SurveyStatus { initial, invalid, submitting, success, failure }

class SurveyState {
  final SurveyStatus status;
  final String? errorMessage;

  const SurveyState({this.status = SurveyStatus.initial, this.errorMessage});

  SurveyState copyWith({SurveyStatus? status, String? errorMessage}) {
    return SurveyState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

@Riverpod(keepAlive: true)
class SurveyNotifier extends _$SurveyNotifier {
  @override
  SurveyState build() {
    return const SurveyState();
  }

  Future<void> submit(Map<String, dynamic> formData) async {
    state = state.copyWith(status: SurveyStatus.submitting, errorMessage: null);

    // 将表单数据映射为 Entity
    try {
      final survey = SurveyEntity(
        username: formData['username'] as String,
        role: formData['role'] as String,
        isFreelancer: formData['isFreelancer'] as bool,
        hourlyRate: formData['hourlyRate'] as double?,
        feedback:
            (formData['feedback'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        submissionDate: DateTime.now(),
      );

      final submitSurvey = ref.read(submitSurveyUseCaseProvider);
      final result = await submitSurvey(survey);

      result.fold(
        (failure) => state = state.copyWith(
          status: SurveyStatus.failure,
          errorMessage: failure.message,
        ),
        (_) => state = state.copyWith(status: SurveyStatus.success),
      );
    } catch (e) {
      state = state.copyWith(
        status: SurveyStatus.failure,
        errorMessage: 'Invalid form data: $e',
      );
    }
  }

  void reset() {
    state = const SurveyState();
  }
}

