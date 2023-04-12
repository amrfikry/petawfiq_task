import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petawfiq_task/model/survey.dart';

class SurveyWidget extends StatelessWidget {
  final Survey survey;
  const SurveyWidget({super.key, required this.survey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (survey.imagePath != null)
                  Image.file(File(survey.imagePath!)),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                survey.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                survey.date.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: survey.questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Flexible(
                      child: Text(
                        survey.questions[index].questionText,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
