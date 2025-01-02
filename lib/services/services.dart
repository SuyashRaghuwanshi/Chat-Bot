import 'package:flutter/material.dart';
import 'package:helper/widgets/drop_down.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(18.0),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  "Chosen Model:",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Flexible(flex: 2, child: ModelsDropDownWidget()),
            ],
          ),
        );
      },
    );
  }
}
