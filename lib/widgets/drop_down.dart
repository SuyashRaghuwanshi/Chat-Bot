import 'package:flutter/material.dart';
import 'package:helper/constants/constants.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String currentModels = "Model1";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: currentModels,
        dropdownColor: scaffoldBackgroundColor,
        iconEnabledColor: Colors.white,
        items: getModelsItem,
        onChanged: (value) {
          setState(() {
            currentModels = value.toString();
          });
        });
  }
}
