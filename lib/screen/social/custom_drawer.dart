import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planear/theme/font_styles.dart';

class CustomDrawer extends StatelessWidget{

   const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: 
          <Widget>[
            ListTile(
              leading: SvgPicture.asset("assets/icons/mypage.svg"),
              title: Text("친구 추가", style: FontStyles.Main,),
              onTap: (){

              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/icons/share.svg"),
              title: Text("공유 하기", style: FontStyles.Main,),
              onTap: (){

              },
            ),
          ]
        )
    );
  }

}