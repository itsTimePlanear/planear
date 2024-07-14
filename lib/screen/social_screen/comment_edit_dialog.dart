import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/edit_qa.dart';
import 'package:planear/widgets/state_message_percent.dart';
import 'package:planear/widgets/state_message_qa.dart';
import 'package:planear/widgets/state_message_todo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Future<bool> showCommentEditDialog(
  BuildContext context) async {
    bool result = false;
    final pageController = PageController();

    await showDialog(context: context, 
    builder: (BuildContext context){


      return Dialog(
        alignment: Alignment.topCenter,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
        child : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(30),
            Text("상태메세지", style: FontStyles.Title.copyWith(color: Colors.white),),
            Gap(50),
            Container(
              height: 150,
              child: PageView(
                controller: pageController,
                children: [
                  StateMessagePercent(),
                  StateMessageTodo(),
                  EditQa(),
                ],
              ),
            ),
            Gap(10),
            Container(
	width: double.infinity,
    alignment: Alignment.center,
	child: SmoothPageIndicator(
		controller: pageController
		,count: 3,
		effect: const ScrollingDotsEffect(
			activeDotColor: Colors.white,
          dotColor: Colors.black,
			maxVisibleDots: 5,
			radius: 8,
			spacing: 10,
			dotHeight: 12,
			dotWidth: 12,
		)),
	),
            Gap(30),
          ],
        ),
      );
    });
    return result;
  }
