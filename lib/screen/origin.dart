import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/strings.dart';

/* 原産地画面 */
class Origin extends StatefulWidget {
  @override
  _OriginState createState() => _OriginState();
}

class _OriginState extends State<Origin> {
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