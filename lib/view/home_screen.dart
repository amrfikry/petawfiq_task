import 'package:flutter/material.dart';
import 'package:petawfiq_task/view/adding_survey.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petawfiq_task/view/widgets/survey_widget.dart';

import '../controller/survey_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final surveys = ref.watch(surveyProvider).surveys;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Surveys'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: surveys.length,
        itemBuilder: (BuildContext context, int index) {
          final survey = surveys[index];
          return SurveyWidget(
            survey: survey,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddingSurveryScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
