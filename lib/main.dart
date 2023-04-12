import 'package:flutter/material.dart';
import 'package:petawfiq_task/view/adding_survey.dart';
import 'package:petawfiq_task/view/home_screen.dart';
import 'package:petawfiq_task/view/survey_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surveys',
      theme: ThemeData.light(useMaterial3: true),
      home: const HomeScreen(),
      routes: {
        AddingSurveryScreen.routeName: (context) => const AddingSurveryScreen(),
        SurveyScreen.routeName: (context) => SurveyScreen(
            id: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
