import 'package:flutter/material.dart';
import 'package:planear/theme/font_styles.dart';

Future<bool> showCustomDialog(
    BuildContext context, String text, String left, String right) async {
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
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: FontStyles.Main.copyWith(color: Colors.black)),
              ),
              SizedBox(
                  width: 311,
                  height: 48,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              result = false;
                              Navigator.pop(context);
                            },
                            child: _leftButton(context, left)),
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              result = true;
                              Navigator.pop(context);
                            },
                            child: _rightButton(context, right)),
                      )
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
    alignment: Alignment.center,
    decoration: const ShapeDecoration(
      color: Color(0xFFF1F1F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
      ),
    ),
    child: Text(left,
        textAlign: TextAlign.center,
        style: FontStyles.Btn.copyWith(color: Colors.black)),
  );
}

Widget _rightButton(context, String right) {
  return Container(
    alignment: Alignment.center,
    decoration: const ShapeDecoration(
      color: Color(0xFF2F2E2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
      ),
    ),
    child: Text(right,
        textAlign: TextAlign.center,
        style: FontStyles.Btn.copyWith(color: Colors.white)),
  );
}
