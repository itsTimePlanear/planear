import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/status_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/todo_box.dart';
import 'package:planear/screen/social_screen/comment_edit_dialog.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';

class StateMessageTodo extends ConsumerStatefulWidget{

  const StateMessageTodo({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StateMessageTodoState();
}

class _StateMessageTodoState extends ConsumerState<StateMessageTodo>{
  @override
  Widget build(BuildContext context) {
    
    return _stateMessageTwo(DateTime.now().month, DateTime.now().day);
  }

    Widget _stateMessageTwo(int month, int day){

    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width-50,
      height: 150,
      decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
      ), color: Colors.white, shadows: const[BoxShadow(
       color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 0),
            spreadRadius: 2,
      )]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("오늘의 일정", style: FontStyles.CommentCard.copyWith(color: AppColors.sub_black)),
            Text("${month}월 ${day}일", style: FontStyles.Headline)
        ],
          ),
          Gap(50),
        Flexible(child: TodoBox()),
        GestureDetector(
              child: SvgPicture.asset("assets/icons/comment_pencil.svg"),
              onTap: (){
                showCommentEditDialog(context, ref);
              },)
        ]
          ,
      ),
    );

  }
}
    
 