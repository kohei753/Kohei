import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'detail.dart';

/* 一日の献立画面 */
class DailyMenu extends StatefulWidget {
  final Menu menu;
  final Child child;
  DailyMenu({Key key, this.menu, this.child}) : super(key: key);

  @override
  _DailyMenuState createState() => _DailyMenuState();
}

class _DailyMenuState extends State<DailyMenu> {
  /* 引っ張ってきたデータちゃん */
  Menu menu;
  Child child;

  /* 初期化処理 */
  @override
  void initState() {
    super.initState();
    menu = widget.menu;
    child = widget.child;
  }

  /* 詳細画面への遷移 */
  void handleToDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/detail'),
        builder: (BuildContext context) =>
            Detail(dailyMenu: menu, child: child, menuNum: 2,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      child: Text('詳細画面'),
      onPressed: handleToDetail,
    );
  }
}
