import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:planear/riverpod/avatar_screen_riverpod/avatar_wearing_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/status_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/avatar_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_share/social_share.dart';

class ShareScreen extends ConsumerStatefulWidget {
  const ShareScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShareState();
}

class _ShareState extends ConsumerState<ShareScreen> {
  final List<GlobalKey> repaintBoundaryKeys =
      List.generate(3, (_) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final String name = ref.watch(nameChangeStateNotifierProvider);
    final pageController = PageController();
    final achievementProvider = ref.read(statusAchievementNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:
            Text("공유하기", style: FontStyles.Title.copyWith(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  Center(child: _template(1, name, achievementProvider.achievementRate, 0)),
                  Center(child: _template(2, name, achievementProvider.achievementRate, 1)),
                  Center(child: _template(3, name, achievementProvider.achievementRate, 2))
                ],
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
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
              onTap: () {
                

    showModalBottomSheet(
     backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: AppColors.main1,
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),
          //padding: EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               _modalBar(context),
              ListTile(
                leading:  SvgPicture.asset("assets/icons/insta.svg"),
                title: Text('인스타그램 스토리', style: FontStyles.Btn.copyWith(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                 _shareInsta(pageController.page!.toInt());
                },
              ),
              VerticalDivider(thickness: 2, width: 280, color: Color(0xFF505050)),
              ListTile(
                leading:  SvgPicture.asset("assets/icons/social_download2.svg"),
                title: Text('이미지 저장하기', style: FontStyles.Btn.copyWith(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                  save(pageController.page!.toInt());
                  Fluttertoast.showToast(
                    msg: "사진이 저장되었습니다.",
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: AppColors.main2,
                    textColor: AppColors.white,
                    fontSize: 14,
                    toastLength: Toast.LENGTH_SHORT);
                },
              ),
              SizedBox(height: 20),
              
            ],
          ),
        );
      });
                
            
                
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)),
                width: MediaQuery.sizeOf(context).width - 50,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/sharemenu.svg"),
                    Text("공유하기",
                        style: FontStyles.Btn.copyWith(color: Colors.white))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _template(int type, String nickname, int rate, int index) {
    Widget template;
    if (type == 1) {
    template = Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/icons/template_fix1.png"),
        _character(),
        Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [ 
            Gap(0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gap(0),
                CircularPercentIndicator(
                  radius: 30,
                  lineWidth: 11,
                  percent: rate.toDouble() / 100,
                  center: Text(
                    "${rate}%",
                    style: TextStyle(fontSize: 16, fontFamily: 'PretendardSemi',  color: Colors.black),
                  ),
                  progressColor: AppColors.main1,
                  circularStrokeCap: CircularStrokeCap.round,
                 
                        ),
              ],
            ),
            const Gap(75)
            ],
          ),
      ],
    );
  } else if (type == 2) {
      template = Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset("assets/icons/template_fix2.png",height: 600,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(100),
                          Gap(0),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gap(0),
                CircularPercentIndicator(
              radius: 33,
              lineWidth: 11,
              percent: rate.toDouble() / 100,
              center: Text(
                "${rate}%",
                style: TextStyle(fontSize: 16, fontFamily: 'PretendardSemi',  color: Colors.white),
              ),
              progressColor: AppColors.white,
              circularStrokeCap: CircularStrokeCap.round,
            
                    ),
              ],
            ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_character(), const Gap(110),
            ],
          ),
        ],
      );
    } else {
      template = Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset("assets/icons/templates_fix3.png", height: 600,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_character(), const Gap(70)],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(100),
                           Gap(0),
Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gap(0),
                CircularPercentIndicator(
              radius: 33,
              lineWidth: 11,
              percent: rate.toDouble() / 100,
              center: Text(
                "${rate}%",
                style: TextStyle(fontSize: 16, fontFamily: 'PretendardSemi',  color: Colors.white),
              ),
              progressColor: AppColors.white,
              circularStrokeCap: CircularStrokeCap.round,
            
                    ),
              ],
            ),
            ],
          ),
        ],
      );
    }

    return RepaintBoundary(
      key: repaintBoundaryKeys[index],
      child: SafeArea(child: template),
    );
  }

  Widget _character() {
    final wearing = ref.watch(avatarWearingProvider);

    return AvatarShower(null, 150, wearing);
  }
    Widget _modalBar(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }

  void save(int index) async {
    final boundary = repaintBoundaryKeys[index]
        .currentContext!
        .findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final path =
        await ImageGallerySaver.saveImage(byteData!.buffer.asUint8List());
    debugPrint(path.toString());
  }


  Future<void> _shareInsta(int index) async {
    try {
      RenderRepaintBoundary? boundary = repaintBoundaryKeys[index].currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        final image = await boundary.toImage(pixelRatio: 2);
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        final tempDir = await getTemporaryDirectory();
        File file = await File('${tempDir.path}/shared_image.png').create();
        await file.writeAsBytes(pngBytes);

        SocialShare.shareInstagramStory(
          imagePath : file.path,
          backgroundTopColor: "#ffffff",
          backgroundBottomColor: "#000000",
          appId: "com.planear.planear",
        );
      } else {
        debugPrint("Boundary is null");
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }


}