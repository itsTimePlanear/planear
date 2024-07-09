import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/state_message_percent.dart';
import 'package:planear/widgets/state_message_qa.dart';
import 'package:planear/widgets/state_message_todo.dart';

Future<bool> showCommentEditDialog(
  BuildContext context) async {
    bool result = false;

    await showDialog(context: context, 
    builder: (BuildContext context){

      return Dialog(
        alignment: Alignment.topCenter,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
        child : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(30),
            Text("상태메세지", style: FontStyles.Title.copyWith(color: Colors.white),),
            Gap(50),
            Container(
              height: 150,
              child: PageView(
                children: [
                  StateMessagePercent(),
                  StateMessageTodo(),
                  StateMessageQa(),
                ],
              ),
            ),
            Gap(30),
          ],
        ),
      );
    });
    return result;
  }
