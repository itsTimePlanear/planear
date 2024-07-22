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

class ShareScreen extends ConsumerStatefulWidget {
  const ShareScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShareState();
}

class _ShareState extends ConsumerState<ShareScreen> {
  final List<GlobalKey> repaintBoundaryKeys =
      List.generate(3, (_) => GlobalKey());

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
                onPageChanged: (index) {
                  currentPage = index;
                },
                controller: pageController,
                children: [
                  Center(child: _template(1, name, 5, 0)),
                  Center(child: _template(2, name, 5, 1)),
                  Center(child: _template(3, name, 5, 2))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
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
                save(pageController.page!.toInt());
                Fluttertoast.showToast(
                    msg: "사진이 저장되었습니다.",
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: AppColors.main2,
                    textColor: AppColors.white,
                    fontSize: 14,
                    toastLength: Toast.LENGTH_SHORT);
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
                    SvgPicture.asset("assets/icons/social_download2.svg"),
                    Text("이미지 저장하기",
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

  Widget _template(int type, String nickname, int achievementRate, int index) {
    Widget template;
    if (type == 1) {
      template = Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("assets/icons/social_template1.png"),
          _character(nickname)
        ],
      );
    } else if (type == 2) {
      template = Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset("assets/icons/social_template2.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_character(nickname), const Gap(50)],
          ),

        ],
      );
    } else {
      template = Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset("assets/icons/social_template3.png"),
          _character(nickname),
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

    return AvatarShower(null, 180, wearing);
  }
}
