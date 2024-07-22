import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/status_riverpod.dart';
import 'package:planear/screen/social_screen/comment_edit_dialog.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/riverpod/social_riverpod/todo_box.dart';

class StateMessageQa extends ConsumerStatefulWidget{


  const StateMessageQa({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StateMessageQaState();
}

class _StateMessageQaState extends ConsumerState<StateMessageQa>{

  @override
  Widget build(BuildContext context) {
    final qnaProvider = ref.read(statusQnaNotifierProvider);
    return _stateMessageThree(qnaProvider.question, qnaProvider.answer);
  }

    
    Widget _stateMessageThree(String? question, String? answer){

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 10, left: 16, right: 16),
      width: MediaQuery.sizeOf(context).width-50,
      height: 170,
      decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
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
          GestureDetector(
              child: SvgPicture.asset("assets/icons/comment_pencil.svg"),
              onTap: (){
                showCommentEditDialog(context, ref);
              },)
        ],),
        Gap(6),
        Text(' Q.  ${question}' ?? "질문을 선택해주세요", style: FontStyles.Coin,),
        Gap(5),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween
          children: [
            Text(" A. ", style: FontStyles.Coin,),
            Container(
              width: MediaQuery.sizeOf(context).width -110,
              height: 80,
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ), color: AppColors.main3),
              child: Row(
                children: [
                  Expanded(
                    child: 
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      maxLines: 2, overflow: TextOverflow.ellipsis,
                      "${answer}" ?? "답변을 입력해주세요",style: FontStyles.Main,),
                  )),
                ],
              ),
            )
          ],
        )
      ],),
    );
  }
}