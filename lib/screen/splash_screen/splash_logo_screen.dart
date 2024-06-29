import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/main.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/screen/main_screen/main_screen.dart';
import 'package:planear/screen/splash_screen/naming_screen.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/theme/local_db.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashLogoState();
}

class _SplashLogoState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    // storage.deleteAll();

    //do something!

    //initialize app data

    //check network
    //check app version
    //get user data from local DB
    //get user data from server
    // _moveToMainPage();
    checkUserData();
    super.initState();
  }

  _moveToMainPage() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ));
  }

  _moveToLoginPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NamingScreen()));
  }

  checkUserData() async {
    final String? name = await storage.read(key: LocalDB.name);
    final String? id = await storage.read(key: LocalDB.id);
    debugPrint('${name ?? '이름'}확인');
    if (name == null || id == null) {
      _moveToLoginPage();
    } else {
      ref.read(nameChangeStateNotifierProvider.notifier).setName(name);
      ref.read(idChangeStateNotifierProvider.notifier).setId(int.parse(id));
      _moveToMainPage();
    }
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
