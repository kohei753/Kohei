import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart' as menus;
import 'package:sample/data/child.dart' as child;

/* 一日の献立画面 */
class DailyMenu extends StatefulWidget {
  @override
  _DailyMenuState createState() => _DailyMenuState();
}

class _DailyMenuState extends State<DailyMenu> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('今日の献立♡');
  }
}