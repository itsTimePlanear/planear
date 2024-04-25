import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/screen/main_screen/main_screen.dart';

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
    _moveToMainPage();
  }

  _moveToMainPage() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: const BoxDecoration(color: Colors.grey),
        child: const Center(
          child: Text(
            '로고 \n자리',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
