import 'package:petawfiq_task/model/question.dart';

class Survey {
  final String id;
  final String title;
  final List<Question> questions;
  final DateTime date;
  final String? imagePath;

  Survey({
    required this.id,
    required this.title,
    required this.questions,
    required this.date,
    this.imagePath,
  });
}
