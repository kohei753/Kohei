import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';

/* 一日の献立画面 */
class DailyMenu extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final Child child;
  DailyMenu({Key key, this.menus, this.child}) : super(key: key);

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