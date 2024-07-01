import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/todo.dart';

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
              isDone ? Container(
              width: 15, height: 15,
              color: AppColors.main1,
            ) : SvgPicture.asset("assets/icons/todo_checked.svg"),
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
    final state = ref.watch(todoModelStateProvider);

    return ListView.builder(
      padding: EdgeInsets.zero,
         shrinkWrap: true,
        itemCount: state.count,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return TodoCard(todoText: state.todos[index].title, isDone: state.todos[index].isCompleted,);
        },
      );
  }
}