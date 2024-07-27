import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:planear/repository/social_screen/comment_question.dart';
import 'package:planear/riverpod/social_riverpod/status_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';

class TodoCard extends ConsumerWidget {
  final String todoText;
  final bool isDone;
  
  const TodoCard({
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

class TodoBox extends ConsumerWidget {
  const TodoBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final todoProvider = ref.watch(todayScheduleStateNotifierProvider);
    debugPrint('길이${todoProvider.length.toString()}');
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: todoProvider.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return TodoCard(
          todoText: todoProvider[index].title ?? '할일이 없습니다',
          isDone: todoProvider[index].complete ?? false, 
        );
      },
    );
  }
}