import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:planear/riverpod/social_riverpod/todo_box.dart';
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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("오늘의 일정 달성률", style: FontStyles.Schedule.copyWith(color: Colors.black)),
            Gap(20),
           SizedBox( 
          height: 170,
           child:  _avatarListWidget(5)),
           Gap(20),
           Text("최신 소식", style: FontStyles.Schedule.copyWith(color: Colors.black)),
            Gap(20),
             _shareButton(),
             _stateMessageList(5),
             
          ],
        ))
      );
    
  }

  Widget _avatarListWidget(int count, ){

    return ListView.builder(
      scrollDirection: Axis.horizontal,
       physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext ctx, int idx) {
        if(idx == 0){
          return _avatarMyCardWidget("assets/icons/avatar2.png", "김춘삼", 50);
        } else{
          return _avatarCardWidget("assets/icons/avatar2.png", "김춘삼", 50);
        }
    }, 
    itemCount: count,);
  }

  Widget _avatarCardWidget(String prictureUrl, String name, int percent){

    return Container(
      width: MediaQuery.sizeOf(context).width*0.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(8),
           //Image.network(prictureUrl),
           Image.asset(prictureUrl, width: MediaQuery.sizeOf(context).width*0.2, height: 100,),
           Text(name, style: FontStyles.socialName.copyWith(color: Colors.black), ),
           Gap(5),
           Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 8.0,
                animationDuration: 2500,
                percent: 0.5,
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

  Widget _avatarMyCardWidget(String prictureUrl, String name, int percent){

    return Container(
      width: MediaQuery.sizeOf(context).width*0.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColors.main1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Gap(8),
           //Image.network(prictureUrl),
           Image.asset(prictureUrl, width: MediaQuery.sizeOf(context).width*0.2, height: 100),
           Text(name, style: FontStyles.socialName.copyWith(color: Colors.white), ),
           Gap(5),
           Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 8.0,
                animationDuration: 2500,
                percent: 0.5,
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

  Widget _shareButton(){

    return Row(
    children: [
      GestureDetector(
        onTap: (){
          
        },
        child: Container(
          child: Stack(
            children: [
              Container(
               padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
          
                width: MediaQuery.sizeOf(context).width-50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Text("상태 메세지를 업데이트 해 친구들에게 공유하세요.", style: FontStyles.Week.copyWith(color: Colors.black),),
            ),
              
          Positioned(child: SvgPicture.asset("assets/icons/social_pencil.svg"),
          )]),
        ),
      )
    ],
          );
  }

  Widget _stateMessageList(int count){

    return ListView.builder(
      scrollDirection: Axis.vertical,
       physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext ctx, int idx) {
      return _messageContainer("이춘삼", "assets/icons/social_profile_avatar.png", 1, 1);
        
    }, 
    itemCount: count,);
  }

  Widget _messageContainer(String name, String profileUrl, int date, int type){
    
    return Column(
      children: [
        Row(
          children: [
            //Image.network(prictureUrl),
           Image.asset(profileUrl,width: MediaQuery.sizeOf(context).width*0.1, height: MediaQuery.sizeOf(context).height*0.1,),
           Gap(8),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(name+"님이 상태메세지를 업데이트 했어요.", style: FontStyles.DatePopup.copyWith(color: Colors.black)),
               Text(date.toString()+"hour ago", style: FontStyles.scheduleSuccess.copyWith(color: AppColors.sub_white),)
             ],
           )
          ],
        ),
        if (type == 1)
        ...[_stateMessageOne(3, 6)],
        if (type == 2)
        ...[_stateMessageTwo(3, 3)],
        if (type ==3)
        ...[_stateMessageThree()]
      ],
    );
  }

  Widget _stateMessageOne( int unCompleted, int total){

    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width - 50,
      height: 145,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15)
      ),
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
            right: 20
            ,child: CircularPercentIndicator(radius: 55,
          lineWidth: 20, percent: 0.45, center: new Text("${((unCompleted/total)*100).toInt()}%", style: TextStyle(fontSize: 24, fontFamily: 'PretendardSemi'),),
          progressColor: AppColors.main1,
          circularStrokeCap:
    CircularStrokeCap.round,
          ))
        ])
    
    );
  }

  Widget _stateMessageTwo(int month, int day){

    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width - 50,
      height: 145,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15)
      ),
        ),
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
            Text("${month}월 ${day}일", style: FontStyles.Headline)
        ],
          ),
          Gap(50),
        Flexible(child: TodoBox()),
        ]
          ,
      ),
    );

  }

  Widget _stateMessageThree(){

    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width-50,
      height: 145,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15)
      ),
        
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
        ],),
        Gap(6),
        Text("Q. 이번 방학 나의 목표는?", style: FontStyles.Schedule,),
        Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly
          ,children: [
            Text("A.", style: FontStyles.Schedule,),
            Container(
              width: MediaQuery.sizeOf(context).width -100,
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