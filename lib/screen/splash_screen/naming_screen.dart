import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/screen/main_screen/main_screen.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/repository/splash_screen/naming_screen_repo.dart';

class NamingScreen extends ConsumerStatefulWidget {
  const NamingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NamingScreenState();
}

class _NamingScreenState extends ConsumerState<NamingScreen> {
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
                    if (await checkName(nameController.text)) {
                      if (await makeNewName(
                          context, nameController.text, ref)) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()));
                      }
                    }
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
