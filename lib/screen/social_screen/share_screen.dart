import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:planear/riverpod/avatar_screen_riverpod/avatar_wearing_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/status_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/avatar_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShareScreen extends ConsumerStatefulWidget{
  const ShareScreen({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShareState();
  
}

class _ShareState extends ConsumerState<ShareScreen>{
  final GlobalKey repaintBoundary1 = GlobalKey();
  final GlobalKey repaintBoundary2 = GlobalKey();
  final GlobalKey repaintBoundary3 = GlobalKey();

  int currentPage = 0;
  

  void save() async {
    GlobalKey key;
    switch (currentPage) {
      case 0:
        key = repaintBoundary1;
        break;
      case 1:
        key = repaintBoundary2;
        break;
      case 2:
        key = repaintBoundary3;
        break;
      default:
        key = repaintBoundary1;
        break;
    }
    
    final boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final path = await ImageGallerySaver.saveImage(byteData!.buffer.asUint8List());
    debugPrint(path.toString());
  }

  @override
  Widget build(BuildContext context) {
    final String name = ref.watch(nameChangeStateNotifierProvider);
    final achievementProvider = ref.read(statusAchievementNotifierProvider);
    final pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.of(context).pop();
    },
  ),
        title: Text("공유하기",style: FontStyles.Title.copyWith(color: Colors.black),),
      )
      
      ,body: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  currentPage = index;
                },
                controller: pageController,
                children: [
                  Center(child: _template(1, name, achievementProvider.achievementRate, repaintBoundary1)),
                  Center(child: _template(2, name, 5, repaintBoundary2)),
                  Center(child: _template(3, name, 5, repaintBoundary3)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
              width: double.infinity,
                alignment: Alignment.center,
              child: SmoothPageIndicator(
                controller: pageController
                ,count: 3,
                effect: const ScrollingDotsEffect(
                  activeDotColor: AppColors.main_black,
                  dotColor: Color(0xFFE5E5EC),
                  maxVisibleDots: 5,
                  radius: 8,
                  spacing: 10,
                  dotHeight: 12,
                  dotWidth: 12,
                )),
                            ),
            ),
            GestureDetector(
              onTap: (){
                save();
                Fluttertoast.showToast(
                        msg: "사진이 저장되었습니다.",
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: AppColors.main2,             
                        textColor: AppColors.white,
                        fontSize: 14,
                        toastLength: Toast.LENGTH_SHORT,
                      );
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
              width: MediaQuery.sizeOf(context).width - 50,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/social_download2.svg"),
                  Text("이미지 저장하기", style: FontStyles.Btn.copyWith(color: Colors.white),)
                ],
              ),),
            )
          ],
        ),
      ),
    );
  }

  Widget _template(int type,String nickname, int rate, GlobalKey key){

    Widget template;
    if (type == 1) {
      template = Stack(
        children: [
          Image.asset(
            "assets/icons/template_fix1.png",
            width: 600,
            height: 900,
          ),
          Positioned(
            child: _character(),
            top: 180, left: 140,
          ),
          Positioned(
             bottom: 165, left: 170,
            child: Text(nickname,style: TextStyle(fontSize: 13, fontFamily: 'PretendardSemi'))),
          Positioned(
             bottom: 105, right: 120,
            child: CircularPercentIndicator(radius: 35,
            lineWidth: 12, percent: rate.toDouble()/100, center: new Text("${rate}%", style: TextStyle(fontSize: 20, fontFamily: 'PretendardSemi'),),
            progressColor: AppColors.main1,
            circularStrokeCap:
                CircularStrokeCap.round,
            ),
          )
        ],
      );
    }
    else if(type == 2){
      template = Stack(
        children: [
          Image.asset(
            "assets/icons/social_template2.png",
            width: 600,
            height: 600,
          ),
          Positioned(
            child: _character(),
            top: 270, left: 90,
          ),

        ],
      );
    }
    else{
      template = Stack(
        children: [
          Image.asset(
            "assets/icons/social_template3.png",
            width: 600,
            height: 600,
          ),
          Positioned(
            child: _character(),
            top: 320, left: 90,
          ),
        ],
      );
    }

    return RepaintBoundary(
      key: key,
      child: SafeArea(
        child: Stack(
          children: [
            template,
          ],
        ),
      ),
    );
  }

  Widget _character() {
    final wearing = ref.watch(avatarWearingProvider);

    return Column(
      children: [
        AvatarShower(140, 240, wearing),
        Gap(12),
      ],
    );
  }

}