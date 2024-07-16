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
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Assets.logo))),
          ),
          const Gap(60)
        ],
      ),
    );
  }
}
