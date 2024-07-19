import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/feed.dart';
import 'package:planear/riverpod/social_riverpod/status_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';

class TodoCardFeed extends ConsumerWidget {
  final String todoText;
  final bool isDone;
  
  const TodoCardFeed({
    super.key,
    required this.todoText,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: SizedBox(
        //height: 20,
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Row(
            children: [
              isDone ? SvgPicture.asset("assets/icons/todo_checked.svg") :
              Container(
              width: 15, height: 15,
              color: AppColors.main1,
            ),
              SizedBox(width: 10,),
              Expanded(
                child: Text(
                  todoText,
                  style: FontStyles.Main.copyWith(color: AppColors.main1),
                ),
              ),
              ],
          ),
        ),
      ),
    );
  }
}

class TodoBoxFeed extends ConsumerWidget {
  final List<TodayScheduleFeed>? scheduleList;

  const TodoBoxFeed({Key? key, this.scheduleList}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = scheduleList;

    if (todos == null) {
      return Center(
        child: Text('할 일이 없습니다.', style: FontStyles.Main.copyWith(color: AppColors.main1)),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: todos.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return TodoCardFeed(
          todoText: todos[index].title ?? '할일이 없습니다',
          isDone: todos[index].complete ?? false, 
        );
      },
    );
  }
}