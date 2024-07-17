import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/splash_screen_riverpod/splash.dart';
import 'package:planear/screen/main_screen/main_screen.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/repository/splash_screen/naming_screen_repo.dart';
import 'package:planear/widgets/custom_dialog.dart';

class NamingScreen extends ConsumerStatefulWidget {
  const NamingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NamingScreenState();
}

class _NamingScreenState extends ConsumerState<NamingScreen> {
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    bool focus = ref.watch(nameFocusProvider);
    SplashFocusChange focusController = ref.read(nameFocusProvider.notifier);
    bool duplication = ref.watch(nameDuplicationProvider);
    SplashNameCheck duplicationController =
        ref.read(nameDuplicationProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
              Column(
                crossAxisAlignment: duplication
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 300,
                      height: 48,
                      padding: const EdgeInsets.only(left: 18),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1,
                              color: focus
                                  ? const Color(0xFF111111)
                                  : duplication
                                      ? const Color(0xFFDC0000)
                                      : const Color(0xFFE5E5EC)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: TextField(
                        onTap: () {
                          focusController.setTrue();
                        },
                        onTapOutside: (_) {
                          focusController.setFalse();
                          nameFocus.unfocus();
                        },
                        onEditingComplete: () {
                          focusController.setFalse();
                          nameFocus.unfocus();
                        },
                        onSubmitted: (_) {
                          focusController.setFalse();
                          nameFocus.unfocus();
                        },
                        controller: nameController,
                        focusNode: nameFocus,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '이름을 지어주세요.',
                        ),
                      )),
                  const Gap(10),
                  duplication
                      ? const Text(
                          ' 이미 사용중인 이름입니다.',
                          style: TextStyle(
                            color: Color(0xFFDC0000),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.35,
                          ),
                        )
                      : Container()
                ],
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () async {
                    if (nameController.text.isNotEmpty) {
                      if (await showCustomDialog(
                          context, '아바타 생성을 완료할까요?', '취소', '완료하기')) {
                        if (await checkName(nameController.text)) {
                          if (await makeNewName(
                              context, nameController.text, ref)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen()));
                          }
                        } else {
                          duplicationController.setTrue();
                        }
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
