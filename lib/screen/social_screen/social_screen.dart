import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';

class SocialScreen extends ConsumerStatefulWidget{

  const SocialScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
  _SocialScreenState();
}

class _SocialScreenState extends ConsumerState<SocialScreen>{
  @override
  Widget build(BuildContext ) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              Text("오늘의 일정 달성률", style: FontStyles.Schedule.copyWith(color: Colors.black)),
              _avatarCardWidget(true,"assets/icons/avatar2.png", "김춘삼", 50),
              _avatarMyCardWidget(true,"assets/icons/avatar2.png", "김춘삼", 50),
            ],
          ))
      ],)
      );
    
  }

  Widget _avatarCardWidget(bool mine,String prictureUrl, String name, int percent){

    return Container(
      width: MediaQuery.sizeOf(context).width*0.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           //Image.network(prictureUrl),
           Image.asset(prictureUrl, width: MediaQuery.sizeOf(context).width*0.2, height: MediaQuery.sizeOf(context).height*0.1,),
           Text(name, style: FontStyles.socialName.copyWith(color: Colors.black), ),
           Gap(5),
           Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 10.0,
                animationDuration: 2500,
                percent: 0.8,
                barRadius: const Radius.circular(10),
                progressColor: Colors.black,
                backgroundColor: Color(0xffE5E5EC),
              ),
            ),
          ),
          Gap(2),
          Text("$percent"+"%", style: FontStyles.scheduleSuccess.copyWith(color: Colors.black),)
          ,Gap(2),
        ],),
      ),
    );
  }

  Widget _avatarMyCardWidget(bool mine,String prictureUrl, String name, int percent){

    return Container(
      width: MediaQuery.sizeOf(context).width*0.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColors.main1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           //Image.network(prictureUrl),
           Image.asset(prictureUrl, width: MediaQuery.sizeOf(context).width*0.2, height: MediaQuery.sizeOf(context).height*0.1,),
           Text(name, style: FontStyles.socialName.copyWith(color: Colors.white), ),
           Gap(5),
           Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 10.0,
                animationDuration: 2500,
                percent: 0.8,
                barRadius: const Radius.circular(10),
                progressColor: Colors.white,
                backgroundColor: AppColors.main2,
              ),
            ),
          ),
          Gap(2),
          Text("$percent"+"%", style: FontStyles.scheduleSuccess.copyWith(color: Colors.white),)
          ,Gap(2),
        ],),
      ),
    );
  }

}