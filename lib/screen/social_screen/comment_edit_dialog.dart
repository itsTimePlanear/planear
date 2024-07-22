import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/repository/social_screen/comment_question.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/bottom_navigationbar.dart';
import 'package:planear/widgets/edit_qa.dart';
import 'package:planear/widgets/state_message_percent.dart';
import 'package:planear/widgets/state_message_qa.dart';
import 'package:planear/widgets/state_message_todo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Future<bool> showCommentEditDialog(
  BuildContext context, WidgetRef ref) async {
    bool result = false;
    final pageController = PageController();
    int currentPage = 0;

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
                onPageChanged: (index) {
                  currentPage = index;
                  debugPrint('현재페이지${currentPage}');
                },
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0), 
                      child: StateMessagePercent(),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0), 
                      child: StateMessageTodo(),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: EditQa(),
                    ),
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
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(bottom: 70),
                      height: 50,
                      width: (MediaQuery.sizeOf(context).width-65)/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.white
                      ),
                      child: Center(child: Text("취소" ,style: FontStyles.Btn.copyWith(color: Color(0xFFDC0000)),)),
                    
                    ),
                ),
                  Gap(15),
                GestureDetector(
                  onTap: () async {
                    final editingText = ref.read(controllerProviderState);
                    final selectedQuestionId = ref.read(selectedProviderState);
                    if(currentPage == 0)
                    {
                      await postQuestions(ref, "UNCOMPLETE", "", 0);
                      await getStatus(ref);
                    Navigator.pop(context);
                    ref.read(bottomNavProvider.notifier).state = 1;}
                    else if(currentPage == 1)
                    {
                      await postQuestions(ref, "TODAY_SCHEDULE", "", 0);
                      await getStatus(ref);
                    Navigator.pop(context);
                    ref.read(bottomNavProvider.notifier).state = 1;}
                    else if(currentPage == 2)
                    {
                      if (selectedQuestionId != null) {
                        if(editingText != "")
                        {
                          await postQuestions(ref, "QNA", editingText, selectedQuestionId);
                        Fluttertoast.showToast(
                        msg: "질문에 답해 코인을 5개 획득했어요.",
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: AppColors.main2,             
                        textColor: AppColors.white,
                        fontSize: 14,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      await getStatus(ref);
                    Navigator.pop(context);
                    ref.read(bottomNavProvider.notifier).state = 1;} else{
                        Fluttertoast.showToast(
                        msg: "답변을 입력해주세요.",
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: AppColors.main2,             
                        textColor: AppColors.white,
                        fontSize: 14,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      }
                      } else {
                        Fluttertoast.showToast(
                        msg: "질문을 선택하세요",
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: AppColors.main2,             
                        textColor: AppColors.white,
                        fontSize: 14,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 70),
                    height: 50,
                    width: (MediaQuery.sizeOf(context).width-65)/2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.main_black
                    ),
                    child: Center(child: Text("변경하기" ,style: FontStyles.Btn.copyWith(color: Colors.white),)),
                  
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
    return result;
  }
