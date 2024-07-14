import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/riverpod/social_riverpod/todo_box.dart';

class StateMessageQa extends ConsumerStatefulWidget{


  const StateMessageQa({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StateMessageQaState();
}

class _StateMessageQaState extends ConsumerState<StateMessageQa>{

  @override
  Widget build(BuildContext context) {
    return _stateMessageThree();
  }

    
    Widget _stateMessageThree(){

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween
          ,children: [
          Text("Q&A", style: TextStyle(fontFamily: 'PretendardRegular', fontSize: 13 , color: AppColors.sub_black ),),
          GestureDetector(
              child: SvgPicture.asset("assets/icons/comment_pencil.svg"))
        ],),
        Gap(6),
        Text("Q. 이번 방학 나의 목표는?", style: FontStyles.Schedule,),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly
          ,children: [
            Text("A.", style: FontStyles.Schedule,),
            Container(
              width: MediaQuery.sizeOf(context).width -120,
              height: 40,
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ), color: AppColors.main3),
            )
          ],
        )
      ],),
    );
  }
}