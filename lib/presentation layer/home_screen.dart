import 'package:flutter/material.dart';
import 'package:petawfiq_task/view/adding_survey.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surveys'),
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          {
            Navigator.pushNamed(context, AddingSurveryScreen.routeName);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
