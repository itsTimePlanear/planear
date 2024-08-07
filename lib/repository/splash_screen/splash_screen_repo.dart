import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/main.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/screen/main_screen/main_screen.dart';
import 'package:planear/screen/splash_screen/naming_screen.dart';
import 'package:planear/theme/local_db.dart';

checkUserData(BuildContext context, WidgetRef ref) async {
  await Future.delayed(const Duration(seconds: 2));
  final String? name = await storage.read(key: LocalDB.name);
  final String? id = await storage.read(key: LocalDB.id);
  final String? code = await storage.read(key: LocalDB.memberCode);
  debugPrint('${name ?? '이름없음'} 확인');
  debugPrint('${id ?? '아이디없음'} 확인');
  debugPrint('${code ?? '코드없음'} 확인');
  if (name == null || id == null || code == null) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NamingScreen(),
        ));
  } else {
    ref.read(nameChangeStateNotifierProvider.notifier).setName(name);
    ref.read(idChangeStateNotifierProvider.notifier).setId(int.parse(id));
    ref.read(codeChangeStateNotifierProvider.notifier).setCode(code);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ));
  }
}
