import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/font_styles.dart';

class ShareScreen extends ConsumerStatefulWidget{
  const ShareScreen({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShareState();
  
}

class _ShareState extends ConsumerState<ShareScreen>{

  @override
  Widget build(BuildContext context) {

    final pageController = PageController();
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
        title: Text("공유하기",style: FontStyles.Title.copyWith(color: Colors.black),),
      )
      
      ,body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            PageView(
              controller: pageController,
              children: [
                
              ],
            ),
            Expanded(child: 
            SizedBox()),
            Container(
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
            width: MediaQuery.sizeOf(context).width - 50,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/social_download2.svg"),
                Text("이미지 저장하기", style: FontStyles.Btn.copyWith(color: Colors.white),)
              ],
            ),)
          ],
        ),
      ),
    );
  }

}