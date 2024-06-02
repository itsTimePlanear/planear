import 'package:planear/model/schedule.dart';
import 'package:planear/theme/colors.dart';

Schedule schedule1 = Schedule(
    id: '1111',
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 3)),
    name: '1번',
    color: AppColors.color1);
Schedule schedule2 = Schedule(
    id: '2222',
    start: DateTime.now().add(Duration(days: 2)),
    end: DateTime.now().add(Duration(days: 4)),
    name: '2번',
    color: AppColors.color2);
Schedule schedule3 = Schedule(
    id: '3333',
    start: DateTime.now().add(Duration(days: 4)),
    end: DateTime.now().add(Duration(days: 5)),
    name: '3번',
    color: AppColors.color3);
Schedule schedule4 = Schedule(
    id: '4444',
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 6)),
    name: '4번',
    color: AppColors.color4);
Schedule schedule5 = Schedule(
    id: '5555',
    start: DateTime.now(),
    end: DateTime.now(),
    name: '5번',
    color: AppColors.color5);
List<Schedule> dummy_schedules = [
  schedule1,
  schedule2,
  schedule3,
  schedule4,
  schedule5
];
