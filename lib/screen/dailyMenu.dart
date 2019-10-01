import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:sample/data/foodStuff.dart';
import 'package:sample/data/dish.dart';
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
  var dailyMenuName = [
    "エネルギー",
    "タンパク質",
    "脂質",
    "炭水化物",
    "ナトリウム",
    "カルシウム",
    "マグネシウム",
    "鉄分",
    "亜鉛",
    "ビタミンA",
    "ビタミンB1",
    "ビタミンB2",
    "ビタミンC",
    "食物繊維",
    "食塩相当量"
  ];

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

  /*献立コンソール表示*/
  void testMenuName() {
    for(int i=0; i<_menus[firstDay].menu.length; i++) {
      print(_menus[firstDay].menu[i].name);
    }
  }

  /*栄養素コンソール表示*/
  void testMenuNutrient() {
    print(_menus[firstDay].menuEnergy);
  }

  /*カテゴリー表示*/
  Widget todayCategory(String category) {
    return Container(
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Text(category, style: TextStyle(fontSize: 25)),
    );
  }

  Widget dailyMenuNameList() {
    return ListView.builder(
      itemCount: _menus[firstDay].menu.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return Chip(
          label: Text(_menus[firstDay].menu[i].name),
        );
      },
    );
  }

  Widget dailyMenuNutrientList() {
    return ListView.separated(
      itemCount: dailyMenuName.length,
      separatorBuilder: (context, i) => Divider(
        color: Colors.black,
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, i) => Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(dailyMenuName[i]),
//          subtitle: Text(dailyMenuNutrient[i].toString()),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    testMenuName();
    testMenuNutrient();
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          todayCategory("料理名"),
          Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: <Widget>[
                dailyMenuNameList()
              ],
            ),
          ),
          todayCategory("栄養素"),
          Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: <Widget>[
                dailyMenuNutrientList()
              ],
            ),
          )
        ],
      ),
    );
  }
}
