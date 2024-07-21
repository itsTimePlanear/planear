import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:planear/model/social_model/acievement.dart';
import 'package:planear/model/social_model/feed.dart';
import 'package:planear/repository/social_screen/achievement_repo.dart';
import 'package:planear/repository/social_screen/comment_question.dart';
import 'package:planear/repository/social_screen/feed_repo.dart';
import 'package:planear/riverpod/avatar_screen_riverpod/avatar_wearing_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/achievement_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/feed_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/todo_box.dart';
import 'package:planear/riverpod/social_riverpod/todo_box_feed.dart';
import 'package:planear/screen/avatar_screen/main_avatar_screen.dart';
import 'package:planear/screen/main_screen/main_screen.dart';
import 'package:planear/screen/social_screen/comment_edit_dialog.dart';
import 'package:planear/screen/social_screen/feed_profile.dart';
import 'package:planear/screen/social_screen/friend_avatar.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/avatar_widget.dart';

class SocialScreen extends ConsumerStatefulWidget{

  const SocialScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
  _SocialScreenState();
}

class _SocialScreenState extends ConsumerState<SocialScreen>{

 bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
  try {
    await Future.delayed(Duration.zero, () async {
      await achievementGet(ref);
      await feedGet(ref);
    });
  } catch (e) {
    print('Error: $e');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext ) {
    final feedProvider = ref.watch(feedNotifierProvider);
    final achievementProvider = ref.watch(achievementNotifierProvider);

    debugPrint('피드 길이${feedProvider.length}');
    debugPrint('성공률 길이 ${achievementProvider.length}');
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
           child:  _isLoading ?
             Center(
          child: CircularProgressIndicator(),
        )
             :_avatarListWidget(achievementProvider)),
           Gap(20),
           Text("최신 소식", style: FontStyles.Schedule.copyWith(color: Colors.black)),
            Gap(20),
             _shareButton(),
             _isLoading ?
             Center(
          child: CircularProgressIndicator(),
        )
             :_stateMessageList(feedProvider),
             Gap(10)
          ],
        ))
      );
    
  }

  Widget _avatarListWidget(List<Achievement> achievements){
    final achievementProvider = ref.watch(achievementNotifierProvider);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
       physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext ctx, int idx) {
          final item = achievementProvider[idx];
          final achievementRate = item.achievementRate ?? 0;
          final schedule = item.todayScheduleCount ?? 0;

          if(idx == 0){
          return _avatarMyCardWidget(item.nickname, achievementRate, schedule);
        } else{
          return _avatarCardWidget(item.nickname, achievementRate, item.items!, schedule);
        }
    }, 
    itemCount: achievements.length,);
  }

  Widget _avatarCardWidget(String name, int percent, List<ItemsAcievement> items, int schedule){

    Widget isSchedule;
    if (schedule == 0) {
    isSchedule = Column(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 8.0,
              animationDuration: 2500,
              percent: percent.toDouble() / 100,
              barRadius: const Radius.circular(10),
              progressColor: Colors.black,
              backgroundColor: Color(0xffE5E5EC),
            ),
          ),
        ),
        Gap(2),
        Text(
          "$percent%",
          style: FontStyles.scheduleSuccess.copyWith(color: Colors.black),
        ),
      ],
    );
  } else {
    isSchedule = Text(
      "일정 없음",
      style: FontStyles.scheduleSuccess.copyWith(color: Colors.black),
    );
  }

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
           _friendCharacter(items),
           Text(name, style: FontStyles.socialName.copyWith(color: Colors.black), ),
           Gap(5),
           isSchedule
          ,Gap(2),
        ],),
      ),
    );
  }

  Widget _avatarMyCardWidget( String name, int percent, int schedule){

    Widget isSchedule;
    if (schedule == 0) {
    isSchedule = Column(
      children: [
        Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 8.0,
                animationDuration: 2500,
                percent: percent.toDouble()/100,
                barRadius: const Radius.circular(10),
                progressColor: Colors.white,
                backgroundColor: AppColors.main2,
              ),
            ),
          ),
          Gap(2),
          Text("$percent"+"%", style: FontStyles.scheduleSuccess.copyWith(color: Colors.white),)
      ],
    );
  } else {
    isSchedule = Text(
      "일정 없음",
      style: FontStyles.scheduleSuccess.copyWith(color: Colors.white),
    );
  }


    return Container(
      width: MediaQuery.sizeOf(context).width*0.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColors.main1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Gap(8),
           _myCharacter(name),
           Text(name, style: FontStyles.socialName.copyWith(color: Colors.white), ),
           Gap(5),
           isSchedule
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
              
          GestureDetector(
            child: SvgPicture.asset("assets/icons/social_pencil.svg"),
            onTap: () async {
              showCommentEditDialog(context, ref);
            },
          )]),
        ),
      )
    ],
          );
  }

Widget _stateMessageList(List<Feed> feeds) {

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext ctx, int idx) {
        return feeds.map((Feed item) {
          final uncompleteCount = item.uncomplete?.uncompleteCount ?? 0;
          final achievementRate = item.uncomplete?.achievementRate ?? 0;
          return _messageContainer( 
            item.nickname,
            item.items!,
            item.type,
            uncompleteCount,
            achievementRate,
            item.qna?.question ?? '',
            item.qna?.answer ?? '',
            item.todaySchedule
          );
        }).toList()[idx];
      },
      itemCount: feeds.length,
    );
}

  Widget _messageContainer(String name, List<FeedItems> feeds ,String type, int? unCompleted, int? total, String? question, String? answer, List<TodayScheduleFeed>? schedule){
    
    return Column(
      children: [
        Gap(20),
        Row(
          children: [
            Gap(10),
            //Image.network(prictureUrl),
            Stack(children: [
              Container(width: 50, height: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.white),),
              Positioned(top: 0,child: _profileContainer(feeds), left: 0, right: 0,),
              ]),
              Gap(10),
           Container(
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(name+"님이 상태메세지를 업데이트 했어요.", style: FontStyles.DatePopup.copyWith(color: Colors.black)),
                 Gap(10),
                 Text("1hour ago", style: FontStyles.scheduleSuccess.copyWith(color: AppColors.sub_white),)
               ],
             ),
           )
          ],
        ),
        Gap(10),
        if (type == "UNCOMPLETE")
        ...[_stateMessageOne(unCompleted ?? 0, total ?? 0)],
        if (type == "TODAY_SCHEDULE")
        ...[_stateMessageTwo(schedule)],
        if (type == "QNA")
        ...[_stateMessageThree(question, answer)]
      ],
    );
  }



  Widget _stateMessageOne(int unCompleted, int total){

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
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              maxLines: 2,
              '현재 미완료된 일정이\n${unCompleted}개 남아있어요.',
              style: FontStyles.Schedule,
              textAlign: TextAlign.left,
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  children: [
              ])
                ,Positioned(
                  child: CircularPercentIndicator(radius: 55,
                lineWidth: 20, percent: total.toDouble()/100, center: new Text("${total}%", style: TextStyle(fontSize: 24, fontFamily: 'PretendardSemi'),),
                progressColor: AppColors.main1,
                circularStrokeCap:
                CircularStrokeCap.round,
                ))
              ]),
          ],
        ),
      )
    
    );
  }

  Widget _stateMessageTwo(List<TodayScheduleFeed>? schedule){

    return Container(
      padding: const EdgeInsets.all(20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("오늘의 일정", style: FontStyles.CommentCard.copyWith(color: AppColors.main1)),
        ],
          ),
          Gap(80),
        Flexible(child: TodoBoxFeed(scheduleList: schedule,)),
        ]
          ,
      ),
    );

  }

  Widget _stateMessageThree(String? question, String? answer){

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
        Gap(6),
        Text("Q. ${question}" ?? '질문을 선택하세요', style: FontStyles.Schedule,),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("  ${answer}" ?? "답변을 입력해주세요",style: FontStyles.Main,),
                ],
              ),
            )
          ],
        )
      ],),
    );
  }

    Widget _myCharacter(String name) {
    final wearing = ref.watch(avatarWearingProvider);

    return Column(
      children: [
        AvatarShower(MediaQuery.sizeOf(context).width*0.2, 100, wearing),        
      ],
    );
  }

  Widget _friendCharacter(List<ItemsAcievement> items) {

    return Column(
      children: [
        AvatarShowerFriend(MediaQuery.sizeOf(context).width*0.2, 100, items),        
      ],
    );
  }
  Widget _profileContainer(List<FeedItems> items){

    return Column(
      children: [
        AvatarShowerProfile(80, 80, items),        
      ],
    );
    
  }

}