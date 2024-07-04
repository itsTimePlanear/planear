import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        Text("오늘의 일정 달성률", style: FontStyles.Schedule.copyWith(color: Colors.black),)
      ],)
      );
    
  }

}