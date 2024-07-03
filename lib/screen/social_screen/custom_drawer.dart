import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:planear/screen/social_screen/add_friend_screen.dart';
import 'package:planear/theme/font_styles.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.white,
      child: ListView(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100,
            child: Center(
              child: Text(
                '메뉴',
                style: FontStyles.Title.copyWith(color: Colors.black),
              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset("assets/icons/mypage.svg"),
            title: Text("친구 추가", style: FontStyles.Main),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddFriendScreen()));
            },
          ),
          ListTile(
            leading: SvgPicture.asset("assets/icons/share.svg"),
            title: Text("공유 하기", style: FontStyles.Main),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}