import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/strings.dart';

/* ヘルプ画面 */
class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          DevelopingStrings.noDevelop,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}