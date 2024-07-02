import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/theme/colors.dart';


class StateMessagePercent extends StatelessWidget{

  const StateMessagePercent({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width - 50,
      height: 125,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 0),
            spreadRadius: 2,
          )
        ],
      ),
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
            '현재 미완료된 일정이 \nn개 남아있어요.',
            style: FontStyles.Schedule,
            textAlign: TextAlign.left,
          ),
        ])
          ,Positioned(
            bottom: 10
            ,right: 30
            ,child: CircularPercentIndicator(radius: 55,
          lineWidth: 20, percent: 0.45, center: new Text("45"+"%", style: TextStyle(fontSize: 24, fontFamily: 'PretendardSemi'),),
          progressColor: AppColors.main1,
          circularStrokeCap:
    CircularStrokeCap.round,
          ))
        ])
    
    );
    
  }
}