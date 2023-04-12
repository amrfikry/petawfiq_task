import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:petawfiq_task/model/question.dart';
import 'package:petawfiq_task/model/survey.dart';
import 'package:petawfiq_task/view/widgets/main_button.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/survey_controller.dart';

class AddingSurveryScreen extends ConsumerStatefulWidget {
  static const routeName = 'adding_survery';

  const AddingSurveryScreen({super.key});

  @override
  ConsumerState<AddingSurveryScreen> createState() =>
      _AddingSurveryScreenState();
}

class _AddingSurveryScreenState extends ConsumerState<AddingSurveryScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  File? _image;

  _getFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  _getFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  addTextQuestion(QuestionType type,
      {required Function(String?) onFieldSumbitted,
      Function(int, String?)? onChoiceSubmitted}) {
    switch (type) {
      case QuestionType.freeText:
        questionWidgets.add(
          FormBuilderTextField(
            name: 'question_${questionWidgets.length + 1}',
            decoration: const InputDecoration(labelText: 'Free Text'),
            onSaved: onFieldSumbitted,
          ),
        );
        setState(() {});
        break;
      case QuestionType.multipleChoice:
        questionWidgets.add(
          Column(
            children: [
              FormBuilderTextField(
                name: 'question_${questionWidgets.length + 1}',
                decoration: const InputDecoration(labelText: 'Title'),
                onSubmitted: onFieldSumbitted,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return FormBuilderTextField(
                    name: 'q_${questionWidgets.length + 1} choice_$index',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    inputFormatters: [LengthLimitingTextInputFormatter(4096)],
                    onSubmitted: (value) =>
                        onChoiceSubmitted?.call(index, value),
                  );
                },
              ),
            ],
          ),
        );
        setState(() {});
        break;
      default:
    }
  }

  List<Widget> questionWidgets = [];
  List<Question> qustions = [];
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);
    final textController = TextEditingController();
    final FocusNode focusNode = FocusNode();
    return Scaffold(
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: Colors.deepOrangeAccent,
          foregroundColor: Colors.white,
          activeBackgroundColor: Colors.deepPurpleAccent,
          activeForegroundColor: Colors.white,
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          elevation: 8.0,
          shape: const CircleBorder(),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.accessibility),
              label: 'Text Question',
              onTap: () {
                addTextQuestion(QuestionType.freeText,
                    onFieldSumbitted: (title) {
                  qustions.add(Question(
                    questionText: title ?? '',
                    questionType: QuestionType.freeText,
                  ));
                });
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.brush),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              label: 'multiple choice question',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () {},
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text('Adding Survery'),
          elevation: 4,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final values = _formKey.currentState?.value;
                    ref.read(surveyProvider.notifier).addSurvey(Survey(
                          questions: qustions,
                          title: values?['title'] ?? '',
                          date: values?['date_established'] ?? DateTime.now(),
                          imagePath: _image?.path,
                          id: UniqueKey().toString(),
                        ));
                  }
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            FormBuilder(
              key: _formKey,
              child: Column(children: [
                FormBuilderTextField(
                  name: 'title',
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                FormBuilderDateTimePicker(
                  name: 'date_established',
                  enabled: true,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 10)),
                  decoration: const InputDecoration(
                      labelText: 'Date Established',
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal)),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 50,
                ),
                _image != null
                    ? Image.file(
                        _image!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/placeholder-image.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainButton(
                    onTap: _getFromGallery,
                    child: const Text('pick from gallery'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainButton(
                    onTap: _getFromCamera,
                    child: const Text('pick from camera'),
                  ),
                ),
                ...questionWidgets,
              ]),
            ),
          ]),
        ));
  }
}
