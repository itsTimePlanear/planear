import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/repository/splash_screen/splash_screen_repo.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashLogoState();
}

class _SplashLogoState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    //do something!

    //initialize app data

    //check network
    //check app version
    //get user data from local DB
    //get user data from server
    // _moveToMainPage();
    checkUserData(context, ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(Assets.splash1), fit: BoxFit.fill)),
    );
  }
}
