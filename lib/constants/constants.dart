import 'package:flutter/material.dart';
import 'package:helper/widgets/text_widget.dart';

Color scaffoldBackgroundColor = const Color(0xFF343541);
Color cardColor = const Color.fromARGB(255, 32, 44, 125);

List<String> models = [
  'Model1',
  'Model2',
  'Model3',
  'Model4',
  'Model5',
  'Model6',
];
List<DropdownMenuItem<String>>? get getModelsItem {
  List<DropdownMenuItem<String>>? modelsItems =
      List<DropdownMenuItem<String>>.generate(
    models.length,
    (index) => DropdownMenuItem(
      value: models[index],
      child: TextWidget(label: models[index], fontSize: 15),
    ),
  );
  return modelsItems;
}

