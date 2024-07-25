import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/main.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.77,
                height: MediaQuery.sizeOf(context).width * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.splash_logo),
                        fit: BoxFit.fitWidth)),
              ),
              Spacer(),
              Container(
                width: min(542, MediaQuery.sizeOf(context).width),
                height: 468,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage(Assets.splash),
                        fit: BoxFit.none,
                        scale: 4)),
              ),
              Spacer(),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.77,
                height: MediaQuery.sizeOf(context).width * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.splash_logo),
                        fit: BoxFit.fitWidth)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
