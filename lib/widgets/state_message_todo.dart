import 'package:flutter/material.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';

class StateMessageTodo extends StatelessWidget{


  const StateMessageTodo({super.key});

  @override
  Widget build(BuildContext context) {
    
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
        children: [
          Column(
            children: [
            Text("오늘의 일정", style: FontStyles.CommentCard.copyWith(color: AppColors.sub_black)),
            Text("n월 n일", style: FontStyles.Schedule)
        ],
          ),
        
        ]
          ,
      ),
    );
    
  }

}