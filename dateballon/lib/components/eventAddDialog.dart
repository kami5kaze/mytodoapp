import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({Key? key, required context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleEditingController = TextEditingController();
    return Container(
      width: 380,
      height: 300,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: titleEditingController,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
