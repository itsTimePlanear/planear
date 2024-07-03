import 'package:planear/model/schedule.dart';
import 'package:planear/theme/colors.dart';

Schedule schedule1 = Schedule(
    id: 1111,
    categoryId: 1,
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 3)),
    title: '1번',
    color: AppColors.color0);
Schedule schedule2 = Schedule(
    id: 2222,
    categoryId: 1,
    start: DateTime.now().add(const Duration(days: 2)),
    end: DateTime.now().add(const Duration(days: 4)),
    title: '2번',
    color: AppColors.color1);
Schedule schedule3 = Schedule(
    id: 3333,
    categoryId: 3,
    start: DateTime.now().add(const Duration(days: 4)),
    end: DateTime.now().add(const Duration(days: 5)),
    title: '3번',
    color: AppColors.color2);
Schedule schedule4 = Schedule(
    id: 4444,
    categoryId: 4,
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 6)),
    title: '4번',
    color: AppColors.color3);
Schedule schedule5 = Schedule(
    id: 5555,
    categoryId: 5,
    start: DateTime.now(),
    end: DateTime.now(),
    title: '5번',
    color: AppColors.color4);
List<Schedule> dummySchedule = [
  schedule1,
  schedule2,
  schedule3,
  schedule4,
  schedule5
];
