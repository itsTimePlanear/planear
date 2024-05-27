import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/coin_riverpod.dart';
import 'package:planear/screen/main_screen/main_screen.dart';
import 'package:planear/screen/splash_screen/naming_screen.dart';
import 'package:planear/theme/assets.dart';

class SplashLogo extends ConsumerStatefulWidget {
  const SplashLogo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashLogoState();
}

class _SplashLogoState extends ConsumerState<SplashLogo> {
  @override
  void initState() {
    super.initState();
    //do something!

    //initialize app data

    //check network
    //check app version
    //get user data from local DB
    //get user data from server
    // _moveToMainPage();
    _movieToLoginPage();
  }

  _moveToMainPage() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ));
  }

  _movieToLoginPage() async {
    await Future.delayed(const Duration(seconds: 2));
    setdata();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NamingScreen(),
        ));
  }

  setdata() {
    ref.read(coinChangeStateNotifierProvider.notifier).setCoin(20);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Assets.logo))),
          ),
          const Gap(60)
        ],
      ),
    );
  }
}
