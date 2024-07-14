import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/riverpod/social_riverpod/todo_box.dart';

class EditQa extends ConsumerStatefulWidget{

  
  const EditQa({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditQaState();
}

class _EditQaState extends ConsumerState<EditQa>{
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return _stateMessageThree();
  }

    
    Widget _stateMessageThree(){

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
              ),
            )
          ],
        )
      ],),
    );
  }

  Widget _dropDown(){
      List<String> _list = [
    '나의 이번 주 목표는?',
    '최근에 스스로 자랑스러웠던 일은?',
    '요즘 나를 힘들게 하는 것은?',
    '이번 방학 나의 목표는?',
    '이번 방학에 만나고 싶은 사람이나 방문하고 싶은 장소가 있다면?'
  ];

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

        items: _list
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: FontStyles.Main,
                          overflow: TextOverflow.visible,
                        ),
                      ))
                  .toList(),
                  value : selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
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