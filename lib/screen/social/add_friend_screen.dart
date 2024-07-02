import 'package:flutter/material.dart';

class AddFriendScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("친구 추가")
          ],
        ),
      ),
    );
    
  }
}