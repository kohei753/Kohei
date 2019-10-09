import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart' as child;
import 'package:sample/data/dri.dart';
import 'package:sample/screen/entry.dart';
import 'package:sample/screen/home.dart';
import 'secondEntry.dart';

/* 初期登録画面 */
class SecondEntry extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final DRI dri;
  final String name;
  final int sex;
  SecondEntry({Key key, this.menus, this.dri, this.name, this.sex})
      : super(key: key);

  @override
  _SecondEntryState createState() => _SecondEntryState();
}

class _SecondEntryState extends State<SecondEntry> {
  Map<DateTime, Menu> menus = {};
  DRI dri;
  String name;
  int sex;

  child.Child myChild;

/* ホーム画面への遷移 */
  void handleToHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/home'),
          builder: (BuildContext context) =>
              Home(menus: menus, child: myChild, dri: dri),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}
