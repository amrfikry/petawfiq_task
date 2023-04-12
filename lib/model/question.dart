enum QuestionType {
  multipleChoice,
  singleChoice,
  freeText,
}

class Question {
  Question({
    required this.questionText,
    this.answers,
    required this.questionType,
  });

  final List<String?>? answers;
  final String questionText;
  final QuestionType questionType;
}
