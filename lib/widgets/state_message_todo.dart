import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/todo_box.dart';

class StateMessageTodo extends ConsumerWidget{


  const StateMessageTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width - 50,
      height: 125,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 0),
            spreadRadius: 2,
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
            Text("오늘의 일정", style: FontStyles.CommentCard.copyWith(color: AppColors.sub_black)),
            Text("n월 n일", style: FontStyles.Headline)
        ],
          ),
          Gap(30),
        Flexible(child: TodoBox()),
        GestureDetector(
              child: SvgPicture.asset("assets/icons/comment_pencil.svg"))
        ]
          ,
      ),
    );
    
  }

}