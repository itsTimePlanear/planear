import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/schedule.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/date_setting_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_modal_riverpod.dart';
import 'package:planear/riverpod/coin_riverpod.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/utils/color_utils.dart';
import 'package:planear/repository/calendar_screen/end_schedule_repo.dart';
import 'package:planear/repository/calendar_screen/make_schedule_repo.dart';
import 'package:planear/repository/calendar_screen/remove_schedule_repo.dart';
import 'package:planear/repository/coin_repo.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleModalBottomSheet extends ConsumerStatefulWidget {
  const ScheduleModalBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ScheduleModalBottomSheetState();
}

class ScheduleModalBottomSheetState
    extends ConsumerState<ScheduleModalBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ref.read(scheduleStateNotifierProvider).id != 0) {
        nameController.text = ref.read(scheduleStateNotifierProvider).title!;
        textController.text = ref.read(scheduleStateNotifierProvider).detail;
      } else {
        nameController.text = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewController = ref.read(scheduleModalNotifierProvider.notifier);
    final scheduleState = ref.watch(scheduleStateNotifierProvider);
    final scheduleController = ref.read(scheduleStateNotifierProvider.notifier);
    final dateSettingController =
        ref.read(dateSettingNotifierProvider.notifier);
    final dateSettingState = ref.watch(dateSettingNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _backGround(viewController),
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
                    _nameBox(scheduleState, viewController),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _titleController(
                              scheduleController,
                              dateSettingController,
                              scheduleState,
                              dateSettingState),
                          const Gap(20),
                          _colorController(scheduleController, scheduleState),
                          const Gap(20),
                          _infoController(),
                          const Gap(10),
                          scheduleState.finish
                              ? _endText()
                              : scheduleState.id == 0
                                  ? _makeButton(viewController, scheduleState)
                                  : _twoButtons(viewController, scheduleState,
                                      viewController),
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
      ),
    );
  }

  Widget _backGround(viewController) {
    return GestureDetector(
      onTap: () {
        viewController.setFalse();
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }

  Widget _nameBox(
      Schedule scheduleState, ScheduleModalProvider viewController) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Text(
          scheduleState.id == 0 ? '일정 추가' : '일정 보기',
          textAlign: TextAlign.center,
          style: const TextStyle(
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
                  viewController.setFalse();
                },
                child: const Icon(Icons.keyboard_arrow_down_sharp, size: 30)),
          ),
        )
      ],
    );
  }

  Widget _titleController(
      ScheduleProvider scheduleController,
      DateSettingProvider dateSettingController,
      Schedule scheduleState,
      DateSettings? dateSettingState) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            scheduleController.setName(value);
          },
          controller: nameController,
          decoration: InputDecoration(
            prefix: Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(color: Color(0xFF2F2E2C)),
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
        _dateController(scheduleController, dateSettingController,
            dateSettingState, scheduleState),
        dateSettingState == null
            ? Container()
            : Column(
                children: [
                  _calendar(dateSettingController, dateSettingState,
                      scheduleController),
                  const Gap(20)
                ],
              ),
      ],
    );
  }

  Widget _dateController(
    ScheduleProvider watchingScheduleController,
    DateSettingProvider dateSettingController,
    DateSettings? dateSettingState,
    Schedule makeScheduleState,
  ) {
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
                if (dateSettingState == DateSettings.start) {
                  dateSettingController.setNull();
                } else {
                  dateSettingController.setStart();
                }
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
                      '${makeScheduleState.start.year % 100}/${makeScheduleState.start.month}/${makeScheduleState.start.day}',
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
                if (dateSettingState == DateSettings.end) {
                  dateSettingController.setNull();
                } else {
                  dateSettingController.setEnd();
                }
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
                      '${makeScheduleState.end.year % 100}/${makeScheduleState.end.month}/${makeScheduleState.end.day}',
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

  Widget _calendar(
    DateSettingProvider dateSettingController,
    DateSettings dateSettingState,
    ScheduleProvider makeScheduleController,
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

  Widget _colorController(ScheduleProvider watchingScheduleController,
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
                  watchingScheduleController
                      .setCategory(colorToCategory(colorList[index]));
                },
                child: (index == watchingScheduleState.categoryId)
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

  Widget _endText() {
    return const Text(
      '완료된 일정입니다.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF767676),
        fontSize: 14,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _makeButton(
      ScheduleModalProvider scheduleController, Schedule scheduleState) {
    return GestureDetector(
      onTap: () async {
        // await makeSchedule(ref);
        // await getCoin(ref);

        if (await makeSchedule(ref)) {
          ref.read(coinChangeStateNotifierProvider.notifier).addCoin(5);
        }

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

  Widget _twoButtons(ScheduleModalProvider scheduleController,
      Schedule scheduleState, ScheduleModalProvider viewController) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              await removeSchedule(ref).then((_) {
                viewController.setFalse();
              });
            },
            child: Container(
              width: 159,
              height: 48,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFFF4F4F4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '삭제하기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFDC0000),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const Gap(20),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              if (await endSchedule(ref)) {
                viewController.setFalse();
              }
            },
            child: Container(
              width: 163,
              height: 48,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Color(0xFF2F2E2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '일정 완료하기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
