import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/font_styles.dart';

class SocialScreen extends ConsumerStatefulWidget{

  const SocialScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
  _SocialScreenState();
}

class _SocialScreenState extends ConsumerState<SocialScreen>{
  @override
  Widget build(BuildContext ) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              Text("오늘의 일정 달성률", style: FontStyles.Schedule.copyWith(color: Colors.black)),
              _avatarCardWidget("123", "000"),
            ],
          ))
      ],)
      );
    
  }

  Widget _avatarCardWidget(String prictureUrl, String name,){

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         //Image.network(prictureUrl),
         Image.asset("assets/icons/avatar2.png", width: MediaQuery.sizeOf(context).width*0.2, height: MediaQuery.sizeOf(context).height*0.1,),
         Text(name, style: FontStyles.socialName.copyWith(color: Colors.black), )
      ],),
    );
  }

}