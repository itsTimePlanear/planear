import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/avatar_screen_riverpod/avatar_wearing_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/status_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/screen/social_screen/comment_edit_dialog.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/theme/font_styles.dart';
import 'package:planear/widgets/avatar_widget.dart';
import 'package:planear/widgets/state_message_percent.dart';
import 'package:planear/widgets/state_message_qa.dart';
import 'package:planear/widgets/state_message_todo.dart';

class AvatarPage extends ConsumerStatefulWidget {
  const AvatarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends ConsumerState<AvatarPage> {
  
  @override
  Widget build(BuildContext context) {
    
    final String type = ref.watch(statusTypeNotifierProvider);
    final String name = ref.watch(nameChangeStateNotifierProvider);

    Widget stateMessageWidget;
    if (type == "UNCOMPLETE") {
      stateMessageWidget = StateMessagePercent();
    } else if (type == "QNA") {
      stateMessageWidget = StateMessageQa();
    } else {
      stateMessageWidget = StateMessageTodo();
    }

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            const Gap(40),
            stateMessageWidget,
            const Gap(50),
            _character(name),
          ],
        ),
      ),
    );
  }

  _character(String name) {
    final wearing = ref.watch(avatarWearingProvider);

    return Column(
      children: [
        AvatarShower(200, 300, wearing),
        Gap(12),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
