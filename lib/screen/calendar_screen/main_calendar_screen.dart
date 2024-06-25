import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/dummydata/schedule_dummy.dart';
import 'package:planear/riverpod/calendar_page_riverpod/calendar_view_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/focus_day_riverod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/make_schedule_riverpod/make_schedule_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/make_schedule_riverpod/make_schedule_watch_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/select_day_riveropd.dart';
import 'package:planear/riverpod/calendar_page_riverpod/watching_schedule_riveropd/watching_schedule_riverpod.dart';
import 'package:planear/screen/calendar_screen/schedule_container.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/utils/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendarScreen extends ConsumerStatefulWidget {
  const MainCalendarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainCalendarScreenState();
}

class _MainCalendarScreenState extends ConsumerState<MainCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedDay = ref.watch(selectDayStateNotifierProvider);
    final focusDay = ref.watch(focusDayStateNotifierProvider);
    final selectDayController =
        ref.read(selectDayStateNotifierProvider.notifier);
    final focusDayController = ref.read(focusDayStateNotifierProvider.notifier);
    final viewState = ref.watch(claendarViewNotifierProvider);
    final viewStateController = ref.read(claendarViewNotifierProvider.notifier);

    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              const Gap(20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.only(top: 24),
                width: MediaQuery.sizeOf(context).width - 32,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text('${focusDay.year}',
                              style: const TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 18,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              )),
                          const Gap(10),
                          Text(month_eng(focusDay.month),
                              style: const TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 18,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              )),
                          const Spacer(),
                          _calendarTypeChanger(viewStateController, viewState)
                        ],
                      ),
                    ),
                    const Gap(20),
                    _calendarWidget(selectedDay, focusDay, selectDayController,
                        focusDayController, viewState),
                    const Gap(20),
                  ],
                ),
              ),
              const Gap(16),
              Container(
                child: _detailSchedule(selectedDay),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calendarTypeChanger(
      CalendarViewProvider viewStateController, CalendarFormat viewState) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            viewStateController.setState(CalendarFormat.month);
          },
          child: Text(
            'Monthly',
            textAlign: TextAlign.center,
            style: (viewState == CalendarFormat.month)
                ? const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  )
                : const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
          ),
        ),
        const Gap(15),
        GestureDetector(
          onTap: () {
            viewStateController.setState(CalendarFormat.week);
          },
          child: Text(
            'Weekly',
            textAlign: TextAlign.center,
            style: (viewState == CalendarFormat.week)
                ? const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  )
                : const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
          ),
        )
      ],
    );
  }

  Widget _calendarWidget(
    DateTime curretDay,
    DateTime focusDay,
    SelectDayInfoProvider selectDayController,
    FocusDayInfoProvider focusDayController,
    CalendarFormat viewState,
  ) {
    return TableCalendar(
      calendarFormat: viewState,
      // locale: 'ko_KR',
      currentDay: curretDay,
      headerVisible: false,
      focusedDay: focusDay,
      firstDay: DateTime(2022, 01, 01),
      lastDay: DateTime(2027, 01, 01),
      rowHeight: 50,
      daysOfWeekHeight: 40,
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: 21,
              height: 21,
              margin: const EdgeInsets.all(6.0),
              decoration: const BoxDecoration(
                color: AppColors.main2,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${day.day}',
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          );
        },
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Color(0xFF111111),
            fontSize: 13,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
          ),
          weekendStyle: TextStyle(
            color: Color(0xFF111111),
            fontSize: 13,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
          )),

      availableGestures: AvailableGestures.all,
      onDaySelected: (selectedDay, focusedDay) {
        selectDayController.setDay(selectedDay);
        focusDayController.setDay(focusedDay);
      },
      onPageChanged: (focusedDay) {
        focusDayController.setDay(focusedDay);
      },
      onFormatChanged: (format) {
        if (viewState == CalendarFormat.month) {
          ref
              .read(claendarViewNotifierProvider.notifier)
              .setState(CalendarFormat.week);
        } else if (viewState == CalendarFormat.week) {
          ref
              .read(claendarViewNotifierProvider.notifier)
              .setState(CalendarFormat.month);
        }
      },
    );
  }

  Widget _detailSchedule(DateTime currentDay) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      width: MediaQuery.sizeOf(context).width - 32,
      alignment: Alignment.topCenter,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${currentDay.month}월 ${currentDay.day}일 ${weekday_kor(currentDay.weekday)}요일',
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(24),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dummy_schedules.length,
            itemBuilder: (BuildContext context, int index) {
              if (dummy_schedules[index].start.isBefore(currentDay) &&
                  dummy_schedules[index].end.isAfter(currentDay)) {
                return ScheduleContainer(dummy_schedules[index]);
              } else {
                return Container();
              }
            },
          ),
          const Gap(4),
          GestureDetector(
            onTap: () {
              final watchingScheduleController =
                  ref.read(watchingScheduleStateNotifierProvider.notifier);
              watchingScheduleController.setColor('0xff000000');
              watchingScheduleController.setFinish(false);
              watchingScheduleController.setName('');
              watchingScheduleController.setText('');
              ref.read(makeScheduleWatchNotifierProvider.notifier).setTrue();
              final makeScheduleController =
                  ref.read(makeScheduleStateNotifierProvider.notifier);
              makeScheduleController.setStart(DateTime.now());
              makeScheduleController.setEnd(DateTime.now());
            },
            child: Container(
              height: 48,
              padding: const EdgeInsets.all(10),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFF2F2E2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  Gap(6),
                  Text(
                    '일정을 추가하세요.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
