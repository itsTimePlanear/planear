import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/theme/colors.dart';

class StateMessagePercent extends ConsumerStatefulWidget{

  const StateMessagePercent({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StateMessagePercentState();
}

class _StateMessagePercentState extends ConsumerState<StateMessagePercent>{
  @override
  Widget build(BuildContext context) {

    return _stateMessageOne(4, 5);
    
  }

Widget _stateMessageOne( int unCompleted, int total){

    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width-50,
      height: 140,
      decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
      ), color: Colors.white, shadows: const[BoxShadow(
       color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 0),
            spreadRadius: 2,
      )]),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween
          ,children: [
            Text("일정달성률", style: FontStyles.CommentCard.copyWith(color: AppColors.sub_black),),
            GestureDetector(
              child: SvgPicture.asset("assets/icons/comment_pencil.svg"))
          ],
        ),
        Text(
            maxLines: 2,
            '현재 미완료된 일정이\n${unCompleted}개 남아있어요.',
            style: FontStyles.Schedule,
            textAlign: TextAlign.left,
          ),
        ])
          ,Positioned(
            right: 25
            ,child: CircularPercentIndicator(radius: 55,
          lineWidth: 20, percent: ((total - unCompleted)/total), center: new Text("${(((total - unCompleted)/total)*100).toInt()}%", style: TextStyle(fontSize: 24, fontFamily: 'PretendardSemi'),),
          progressColor: AppColors.main1,
          circularStrokeCap:
    CircularStrokeCap.round,
          ))
        ])
    
    );
  }
}




    
