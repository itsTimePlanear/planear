import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/schedule.dart';
import 'package:planear/riverpod/calendar_page_riverpod/calendar_view_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/focus_day_riverod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_modal_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/overall_schedule_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/select_day_riveropd.dart';
import 'package:planear/screen/calendar_screen/schedule_container.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/utils/color_utils.dart';
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
      eventLoader: (day) {
        List<Schedule> schedules = ref.watch(fullDayStateNotifierProvider);
        List<Schedule> day_schedule = [];
        schedules.every((schedule) {
          if (checkTime(schedule, day)) {
            day_schedule.add(schedule);
          }
          return true;
        });
        return day_schedule;
      },
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
        markerBuilder: (context, day, List<Schedule> events) {
          Set colors = {};
          for (var event in events) {
            if (!event.finish) {
              colors.add(event.categoryId);
            }
          }
          List colorList = colors.toList();
          switch (colors.length) {
            case 0:
              return Container();
            case 1:
              return Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                    color: Color(int.parse(categoryToColor(colorList[0])))),
              );
            case 2:
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color:
                              Color(int.parse(categoryToColor(colorList[0])))),
                    ),
                    const Gap(3),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color:
                              Color(int.parse(categoryToColor(colorList[1])))),
                    )
                  ]);
            case 3:
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color:
                              Color(int.parse(categoryToColor(colorList[0])))),
                    ),
                    const Gap(3),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color:
                              Color(int.parse(categoryToColor(colorList[1])))),
                    ),
                    const Gap(3),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color:
                              Color(int.parse(categoryToColor(colorList[2])))),
                    )
                  ]);
            default:
              return Container();
          }
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
    List<Schedule> schedule = ref.watch(fullDayStateNotifierProvider);

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
            itemCount: schedule.length,
            itemBuilder: (BuildContext context, int index) {
              if (checkTime(schedule[index], currentDay)) {
                return ScheduleContainer(schedule[index]);
              } else {
                return Container();
              }
            },
          ),
          const Gap(4),
          GestureDetector(
            onTap: () {
              ref.read(scheduleModalNotifierProvider.notifier).setTrue();
              final scheduleController =
                  ref.read(scheduleStateNotifierProvider.notifier);
              scheduleController.setSchedule(scheduleDummy);
              scheduleController.setStart(DateTime.now());
              scheduleController.setEnd(DateTime.now());
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
