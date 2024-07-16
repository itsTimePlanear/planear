import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/main.dart';
import 'package:planear/repository/social_screen/friend_repo_repo.dart';
import 'package:planear/riverpod/social_riverpod/friend_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/theme/local_db.dart';
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
    final String code = ref.watch(codeChangeStateNotifierProvider);
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
            _body(code),
            Expanded(child: 
            SizedBox()),
            _friendPlusButton()
          ],
        ),
      ),
    );
  }

  Widget _body(String code){
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("나의 코드", style: FontStyles.MainEmphasis.copyWith(color: Colors.black)),
        Gap(20),
        Text(code, style: FontStyles.StoreMenu.copyWith(color: Colors.black),),
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
        onTap: () async {
          debugPrint('텍스트 입력${editingController.text}');
          await getFriendInfo(ref, editingController.text);
          final nickname = ref.read(friendNicknameStateNotifierProvider);
          showCustomDialog(context, "${nickname}님을 친구 리스트에 추가할까요?", "취소", "추가하기", true, editingController.text, ref);
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