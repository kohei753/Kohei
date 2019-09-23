import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'menu.dart' as menus;
import 'child.dart' as child;

/* 設定画面 */
class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
    );
  }
}