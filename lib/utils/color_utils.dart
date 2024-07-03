import 'package:planear/theme/colors.dart';

String categoryToColor(int value) {
  switch (value) {
    case 0:
      return AppColors.color0;
    case 1:
      return AppColors.color1;
    case 2:
      return AppColors.color2;
    case 3:
      return AppColors.color3;
    case 4:
      return AppColors.color4;
    default:
      return '0xfff000000';
  }
}

int colorToCategory(String color) {
  switch (color) {
    case AppColors.color0:
      return 0;
    case AppColors.color1:
      return 1;
    case AppColors.color2:
      return 2;
    case AppColors.color3:
      return 3;
    case AppColors.color4:
      return 4;
    default:
      return 5;
  }
}
