import 'package:petawfiq_task/model/survey.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final surveyProvider = StateNotifierProvider<SurveyNotifier, SurveyState>(
    (ref) => SurveyNotifier());

class SurveyState {
  final List<Survey> surveys;
  SurveyState({this.surveys = const []});

  SurveyState copyWith({
    List<Survey>? surveys,
  }) {
    return SurveyState(
      surveys: surveys ?? this.surveys,
    );
  }
}

class SurveyNotifier extends StateNotifier<SurveyState> {
  SurveyNotifier() : super(SurveyState());

  void addSurvey(Survey survey) {
    state = state.copyWith(surveys: [...state.surveys, survey]);
  }
}
