import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/make_schedule.dart';
import 'package:planear/model/schedule.dart';
import 'package:planear/riverpod/calendar_page_riverpod/make_schedule_riverpod/date_setting_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/make_schedule_riverpod/make_schedule_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/make_schedule_riverpod/make_schedule_watch_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/watching_schedule_riveropd/watching_schedule_riverpod.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/theme/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleModalBottomSheet extends ConsumerStatefulWidget {
  const ScheduleModalBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ScheduleModalBottomSheetState();
}

class ScheduleModalBottomSheetState
    extends ConsumerState<ScheduleModalBottomSheet> {
  List<String> colorList = [
    AppColors.str_color1,
    AppColors.str_color2,
    AppColors.str_color3,
    AppColors.str_color4,
    AppColors.str_color5
  ];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final scheduleController =
        ref.read(makeScheduleWatchNotifierProvider.notifier);
    final watchingScheduleController =
        ref.read(watchingScheduleStateNotifierProvider.notifier);
    final watchingScheduleState =
        ref.watch(watchingScheduleStateNotifierProvider);
    final makeScheduleState = ref.watch(makeScheduleStateNotifierProvider);
    final makeScheduleController =
        ref.read(makeScheduleStateNotifierProvider.notifier);
    final dateSettingController =
        ref.read(dateSettingNotifierProvider.notifier);
    final dateSettingState = ref.watch(dateSettingNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: () {
              scheduleController.setFalse();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.9),
            decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                )),
            width: MediaQuery.sizeOf(context).width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(14),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      const Text(
                        '일정 추가',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF111111),
                          fontSize: 18,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {
                                scheduleController.setFalse();
                              },
                              child: const Icon(Icons.keyboard_arrow_down_sharp,
                                  size: 30)),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onChanged: (value) {
                            watchingScheduleController.setName(value);
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            prefix: Container(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.only(right: 10),
                              decoration:
                                  const BoxDecoration(color: Color(0xFF2F2E2C)),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: '일정 명을 입력하세요.',
                            hintStyle: const TextStyle(
                              color: Color(0xFF767676),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Gap(20),
                        _dateController(watchingScheduleController,
                            dateSettingController, makeScheduleState),
                        dateSettingState == null
                            ? Container()
                            : Column(
                                children: [
                                  _calendar(dateSettingController,
                                      dateSettingState, makeScheduleController),
                                  const Gap(20)
                                ],
                              ),
                        const Gap(20),
                        _colorController(
                            watchingScheduleController, watchingScheduleState),
                        const Gap(20),
                        _infoController(),
                        const Gap(10),
                        _button(scheduleController),
                        const Gap(30)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateController(
      WatchingScheduleProvider watchingScheduleController,
      DateSettingProvider dateSettingController,
      NewSchedule makeScheduleState) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            '날짜 지정',
            style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Gap(12),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                print('첫 날짜 설정');
                dateSettingController.setStart();
              },
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 32,
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F4F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '${makeScheduleState.startDate.year % 100}/${makeScheduleState.startDate.month}/${makeScheduleState.startDate.day}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Gap(5),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.calendar_select))),
                  )
                ],
              ),
            ),
            const Gap(8),
            const Text('>'),
            const Gap(8),
            GestureDetector(
              onTap: () {
                print('끝 날자 설정');
                dateSettingController.setEnd();
              },
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 32,
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F4F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '${makeScheduleState.endDate.year % 100}/${makeScheduleState.endDate.month}/${makeScheduleState.endDate.day}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Gap(5),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.calendar_select))),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _colorController(WatchingScheduleProvider watchingScheduleController,
      Schedule watchingScheduleState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '색상 선택',
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 14,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(12),
        Container(
          width: 261,
          height: 27,
          alignment: Alignment.topLeft,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  watchingScheduleController.setColor(colorList[index]);
                },
                child: (colorList[index] == watchingScheduleState.color)
                    ? Container(
                        width: 27,
                        height: 27,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 20),
                        color:
                            Color(int.parse(colorList[index])).withOpacity(0.5),
                        child: Container(
                            width: 19,
                            height: 19,
                            color: Color(int.parse(colorList[index]))),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 27,
                        height: 27,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Container(
                          width: 19,
                          height: 19,
                          color: Color(int.parse(colorList[index])),
                        )),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _calendar(
    DateSettingProvider dateSettingController,
    DateSettings dateSettingState,
    MakeScheduleProvider makeScheduleController,
  ) {
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextFormatter: (date, locale) {
          return '${date.year}년 ${date.month}월';
        },
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
        ),
      ),
      calendarStyle: CalendarStyle(selectedDecoration: BoxDecoration()),
      focusedDay: DateTime.now(),
      firstDay: DateTime(2022, 01, 01),
      lastDay: DateTime(2026, 01, 01),
      rowHeight: 40,
      onDaySelected: (selectedDay, focusedDay) {
        dateSettingController.setNull();
        if (dateSettingState == DateSettings.start) {
          makeScheduleController.setStart(selectedDay);
        } else {
          makeScheduleController.setEnd(selectedDay);
        }
      },
    );
  }

  Widget _infoController() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '상세설명',
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 14,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(12),
        Container(
          width: MediaQuery.sizeOf(context).width - 32,
          height: 82,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFE5E5EC)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: TextField(
            controller: textController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '메모를 입력하세요.',
              hintStyle: TextStyle(
                color: Color(0xFF767676),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _button(MakeScheduleWatchProvider scheduleController) {
    return GestureDetector(
      onTap: () {
        scheduleController.setFalse();
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width - 32,
        height: 48,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: const Color(0xFF2F2E2C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          '확인',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}