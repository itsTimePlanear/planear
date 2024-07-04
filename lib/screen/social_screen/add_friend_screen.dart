import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/custom_dialog.dart';

class AddFriendScreen extends ConsumerStatefulWidget{
  const AddFriendScreen({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddFriendState();

}

final controllerProvider = StateProvider<String>((ref) {
  return "";
});


class _AddFriendState extends ConsumerState<AddFriendScreen>{

  final editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controllerText = ref.watch(controllerProvider);
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
        title: Text("친구 추가",style: FontStyles.Title.copyWith(color: Colors.black),),
      )
      
      ,body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            _body(),
            Expanded(child: 
            SizedBox()),
            _friendPlusButton()
          ],
        ),
      ),
    );
  }

  Widget _body(){
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("나의 코드", style: FontStyles.MainEmphasis.copyWith(color: Colors.black)),
        Gap(20),
        Text("123456", style: FontStyles.StoreMenu.copyWith(color: Colors.black),),
        Gap(20),
        Text("친구의 코드", style: FontStyles.MainEmphasis.copyWith(color: Colors.black)),
        Gap(10),
        TextFormField(
          decoration: InputDecoration(hintText: "상대방의 코드를 입력하세요.",
          hintStyle: FontStyles.StoreMenu
          ,enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey200),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey200),
              ) ),
          controller: editingController,
          onChanged: (value) {
            print(value);
            ref.read(controllerProvider.notifier).state = value;
          },
        ),
      ],),
      
    );
  }
  Widget _friendPlusButton() {
    return GestureDetector(
        onTap: () {
          showCustomDialog(context, "000님을 친구 리스트에 추가할까요?", "취소", "추가하기");
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width - 50,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.black
              ),
              child: Center(child: Text("친구 추가하기",style: FontStyles.Btn.copyWith(color: Colors.white),)),
        ));
  }
}