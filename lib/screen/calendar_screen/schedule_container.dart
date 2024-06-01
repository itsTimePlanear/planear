import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/schedule.dart';

class ScheduleContainer extends ConsumerStatefulWidget {
  final Schedule schedule;
  const ScheduleContainer(this.schedule, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScheduleContainerState();
}

class _ScheduleContainerState extends ConsumerState<ScheduleContainer> {
  @override
  Widget build(BuildContext context) {
    Schedule schedule = widget.schedule;
    return GestureDetector(
        onTap: () {
          print('object');
        },
        child: Container(
          width: 311,
          height: 43,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 12),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
              color: const Color(0xFFF4F4F4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Row(
            children: [
              Container(
                  width: 10,
                  height: 10,
                  decoration:
                      BoxDecoration(color: Color(int.parse(schedule.color)))),
              const Gap(13),
              Text(
                maxLines: 1,
                schedule.name,
                style: const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ));
  }
}
