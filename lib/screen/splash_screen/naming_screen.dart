import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/main.dart';
import 'package:planear/riverpod/name_riverpod.dart';
import 'package:planear/screen/main_screen/main_screen.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/theme/local_db.dart';
import 'package:http/http.dart' as http;
import 'package:planear/theme/url_root.dart';

class NamingScreen extends ConsumerStatefulWidget {
  const NamingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NamingScreenState();
}

class _NamingScreenState extends ConsumerState<NamingScreen> {
  checkName(String name) async {
    final url = Uri.parse('${UrlRoot.root}/user/check');
    final response = await http.post(url,
        body: jsonEncode({'name': name}),
        headers: {'Content-Type': 'application/json'});
    debugPrint('${response.statusCode}');
    if (response.statusCode == 200) {
      makeNewName(name);
    } else if (response.statusCode == 400) {}
  }

  makeNewName(String name) async {
    debugPrint(name);
    final url = Uri.parse('${UrlRoot.root}/user');
    final response = await http.post(url,
        body: jsonEncode({'name': name}),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      debugPrint(response.body);
      String id = response.body;
      ref.read(nameChangeStateNotifierProvider.notifier).setName(name);
      ref.read(idChangeStateNotifierProvider.notifier).setId(int.parse(id));
      await storage.write(key: LocalDB.name, value: name);
      await storage.write(key: LocalDB.id, value: id);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } else {
      debugPrint('${response.statusCode}');
    }
  }

  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              const Gap(100),
              Container(
                height: 385,
                width: 270,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.naming_screen))),
              ),
              const Gap(10),
              Container(
                  width: 300,
                  height: 48,
                  padding: const EdgeInsets.only(left: 18),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFE5E5EC)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '이름을 지어주세요.',
                    ),
                  )),
              const Spacer(),
              GestureDetector(
                  onTap: () async {
                    checkName(nameController.text);
                  },
                  child: Container(
                    width: 343,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Text(
                      '아바타 만들기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
              const Gap(30)
            ],
          ),
        ),
      ),
    );
  }
}
