import 'package:fluttertoast/fluttertoast.dart';

import '../theme/text_styles.dart';

class ToastUtil {
  static void basic(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: AppTextStyles.B1,
    );
  }
}
