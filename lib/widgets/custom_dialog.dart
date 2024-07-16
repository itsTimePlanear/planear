import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/repository/social_screen/friend_repo.dart';
import 'package:planear/theme/font_styles.dart';

Future<bool> showCustomDialog(
    BuildContext context, String text, String left, String right, bool type, String code, WidgetRef ref) async {
  bool result = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          width: 311,
          height: 164,
          child: Column(
            children: [
              Container(
                width: 311,
                height: 116,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: FontStyles.Main.copyWith(color: Colors.black)
                ),
              ),
              SizedBox(
                  width: 311,
                  height: 48,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            result = false;
                            Navigator.pop(context);
                          },
                          child: _leftButton(context, left)),
                          type ?
                      GestureDetector(
                          onTap: () async {
                            result = true;
                            if(await friendAdd(code, ref)){
                              debugPrint('친구 추가 성공');
                            }
                            Navigator.pop(context);
                          },
                          child: _rightButton(context, right)) : 
                          GestureDetector(
                          onTap: () {
                            result = true;
                            Navigator.pop(context);
                          },
                          child: _rightButton(context, right))
                    ],
                  ))
            ],
          ),
        ),
      );
    },
  );
  return result;
}

Widget _leftButton(context, String left) {
  return Container(
    width: 155.5,
    alignment: Alignment.center,
    decoration: const ShapeDecoration(
      color: Color(0xFFF1F1F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
      ),
    ),
    child: Text(
      left,
      textAlign: TextAlign.center,
      style: FontStyles.Btn.copyWith(color: Colors.black)

    ),
  );
}

Widget _rightButton(context, String right) {
  return Container(
    width: 155.5,
    alignment: Alignment.center,
    decoration: const ShapeDecoration(
      color: Color(0xFF2F2E2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
      ),
    ),
    child: Text(
      right,
      textAlign: TextAlign.center,
      style: FontStyles.Btn.copyWith(color: Colors.white)
    ),
  );
}
