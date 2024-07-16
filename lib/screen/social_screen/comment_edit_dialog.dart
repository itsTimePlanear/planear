import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/repository/social_screen/comment_question.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/edit_qa.dart';
import 'package:planear/widgets/state_message_percent.dart';
import 'package:planear/widgets/state_message_qa.dart';
import 'package:planear/widgets/state_message_todo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Future<bool> showCommentEditDialog(
  BuildContext context, WidgetRef ref) async {
    bool result = false;
    final pageController = PageController();
    await getQuestion(ref);
    showDialog(context: context, 
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
              height: 155,
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
          dotColor: AppColors.main_black,
			maxVisibleDots: 5,
			radius: 8,
			spacing: 10,
			dotHeight: 12,
			dotWidth: 12,
		)),
	),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 70),
                height: 50,
                width: MediaQuery.sizeOf(context).width-50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.main_black
                ),
                child: Center(child: Text("변경하기" ,style: FontStyles.Btn.copyWith(color: Colors.white),)),
              
              ),
            ),
          ],
        ),
      );
    });
    return result;
  }
