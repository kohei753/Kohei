import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
//import 'package:sample/data/menu.dart' as menus;
import 'package:sample/data/child.dart';
import 'detail.dart';
import 'package:intl/intl.dart';

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
  Map<DateTime, Menu> _menus;
  var firstDay = DateTime(2019, 8, 19);
//  Menu menuList = _menus[DateTime(2019, 8, 19)];

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
      )
    );
  }

  void testMenu() {
    for(int i=0; i<_menus[firstDay].menu.length; i++) {
      print(_menus[firstDay].menu[i].name);
    }
  }

  /*カテゴリー表示*/
  Widget todayCategory(String category) {
    return Container(
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Text(category, style: TextStyle(fontSize: 25)),
    );
  }

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return Column(
      children: <Widget>[
        todayCategory("料理名"),
      ],
    );
  }
}
