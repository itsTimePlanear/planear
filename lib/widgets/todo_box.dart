import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/todo.dart';

class TodoCard extends StatelessWidget {
  final String todoText;
  
  const TodoCard({
    super.key,
    required this.todoText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        //height: 20,
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Row(
            children: [
              const Icon(
                Icons.check_box_outline_blank_sharp,
                size: 15,
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
    final state = ref.watch(todoModelStateProvider);

    return ListView.builder(
      padding: EdgeInsets.zero,
         shrinkWrap: true,
        itemCount: state.count,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return TodoCard(todoText: state.todos[index].title);
        },
      );
  }
}