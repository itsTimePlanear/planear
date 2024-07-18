import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/questions.dart';
import 'package:planear/repository/social_screen/comment_question.dart';
import 'package:planear/riverpod/social_riverpod/questions_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/riverpod/social_riverpod/todo_box.dart';

class EditQa extends ConsumerStatefulWidget{

  
  const EditQa({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditQaState();
}

final controllerProviderState = StateProvider<String>((ref) {
  return "";
});

final selectedProviderState = StateProvider<int?>((ref){
  return null;
});

class _EditQaState extends ConsumerState<EditQa>{
  String? selectedValue;
  bool isLoading = false;
  final editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final questionsPrevious = ref.watch(questionNotifierProvider);
    debugPrint('edit${questionsPrevious.toString()}');
    return _stateMessageThree();
  }

    
    Widget _stateMessageThree(){
       final controllerText = ref.watch(controllerProviderState);

    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width-50,
      height: 150,
      constraints: BoxConstraints(minHeight: 150,),
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
              child: SvgPicture.asset("assets/icons/comment_pencil.svg"))
        ],),
        
        Gap(5),
         _dropDown(),
         Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly
          ,children: [
            Text("A.", style: FontStyles.Schedule,),
            Container(
              width: MediaQuery.sizeOf(context).width -120,
              height: 40,
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ), color: AppColors.main3),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
                controller: editingController,
                onChanged: (value) {
                  ref.read(controllerProviderState.notifier).state = value;
          },
              ),
            )
          ],
        )
      ],),
    );
  }

  Widget _dropDown() {
    final questions = ref.watch(questionNotifierProvider);
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        buttonStyleData: ButtonStyleData(
          width: MediaQuery.sizeOf(context).width -90,
          padding: EdgeInsets.only(left: 10, right: 16),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFE5E5EC))
        )),
        iconStyleData: IconStyleData(
          icon: SvgPicture.asset("assets/icons/social_arrow_down.svg")
        ),
        hint: Text("마음에 드는 질문을 선택하세요.", style: FontStyles.Main.copyWith(color: AppColors.sub_black)),

        items: questions
                  .map((Questions item) => DropdownMenuItem<String>(
                        value: item.question,
                        child: Text(
                          item.question,
                          style: FontStyles.Main,
                          overflow: TextOverflow.visible,
                        ),
                      ))
                  .toList(),
                  value : selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                  for (Questions q in questions) {
              if (q.question == value) {
                ref.read(selectedProviderState.notifier).state = q.id;
              }
            }
                });
              },
              dropdownStyleData: DropdownStyleData(
                
                decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
                
              ),
              ),
      
      ),
    );
  }
}