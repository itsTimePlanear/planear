import 'package:flutter/material.dart';
import 'package:planear/widgets/state_message_percent.dart';
import 'package:planear/widgets/state_message_qa.dart';
import 'package:planear/widgets/state_message_todo.dart';

Future<bool> showCommentEditDialog(
  BuildContext context) async {
    bool result = false;

    await showDialog(context: context, 
    builder: (BuildContext context){

      return Dialog(
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
        child : Container(
          height: 150,
          child: PageView(
            children: [
              StateMessagePercent(),
              StateMessageTodo(),
              StateMessageQa(),
            ],
          ),
        ),
        
      );
    });
    return result;
  }
