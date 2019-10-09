import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'detail.dart';

/* 一日の献立画面 */
class DailyMenu extends StatefulWidget {
  final Menu menu;
  final Child child;
  final DRI dri;
  DailyMenu({Key key, this.menu, this.child, this.dri}) : super(key: key);

  @override
  _DailyMenuState createState() => _DailyMenuState();
}

class _DailyMenuState extends State<DailyMenu> {
  /* 引っ張ってきたデータちゃん */
  Menu menu;
  Child child;
  DRI dri;

  /* 初期化処理 */
  @override
  void initState() {
    super.initState();
    menu = widget.menu;
    child = widget.child;
    dri = widget.dri;
  }

  /* 詳細画面への遷移 */
  void handleToDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/detail'),
        builder: (BuildContext context) =>
            Detail(dailyMenu: menu, child: child, dri: dri, menuNum: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return RaisedButton(
      child: Text('詳細画面'),
      onPressed: handleToDetail,
    );
  }
}
