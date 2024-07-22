import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/schedule.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_modal_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/utils/color_utils.dart';

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
          showToast('코인 5개 획득!',
              context: context,
              animation: StyledToastAnimation.none,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: AppColors.main2,
              reverseAnimation: StyledToastAnimation.none,
              duration: const Duration(milliseconds: 1500));

          ref.read(scheduleModalNotifierProvider.notifier).setTrue();
          final scheduleController =
              ref.read(scheduleStateNotifierProvider.notifier);

          scheduleController.setSchedule(schedule);
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
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color: Color(int.parse(
                              categoryToColor(schedule.categoryId))))),
                  schedule.finish
                      ? const Icon(Icons.check, color: Colors.white, size: 15)
                      : Container()
                ],
              ),
              const Gap(13),
              Text(
                maxLines: 1,
                schedule.title ?? '',
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
