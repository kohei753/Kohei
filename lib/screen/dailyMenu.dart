import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'detail.dart';
import 'package:spider_chart/spider_chart.dart';
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

  var _dailyMenuNutrient = [];

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

  /*グラフ用栄養素の作成*/
  double get graphProtein{
    var result = 0.0;
    result = _menus[firstDay].menuProtein;
    return result;
  }
  double get graphVitamin{
    var result = 0.0;
    result = _menus[firstDay].menuRetinol + _menus[firstDay].menuVitaminB1 +
        _menus[firstDay].menuVitaminB2 + _menus[firstDay].menuVitaminC;
    return result;
  }
  double get graphMineral{
    var result = 0.0;
    result = _menus[firstDay].menuCalcium + _menus[firstDay].menuSodium +
        _menus[firstDay].menuIron + _menus[firstDay].menuMagnesium +
        _menus[firstDay].menuZinc + _menus[firstDay].menuSalt;
    return result;
  }
  double get graphCarbohydrate{
    var result = 0.0;
    result = _menus[firstDay].menuDietaryFiber + _menus[firstDay].menuCarbohydrate;
    return result;
  }
  double get graphLipid{
    var result = 0.0;
    result = _menus[firstDay].menuLipid;
    return result;
  }


  /*献立コンソール表示*/
  void testMenuName() {
    for(int i=0; i<_menus[firstDay].menu.length; i++) {
      print(_menus[firstDay].menu[i].name);
    }
  }

  /*栄養素コンソール表示*/
  void testMenuNutrient() {
    print('タンパク質: ' + graphProtein.toString());
    print('ビタミン: ' + graphVitamin.toString());
    print('ミネラル: ' + graphMineral.toString());
    print('炭水化物: ' + graphCarbohydrate.toString());
    print('脂質: ' + graphLipid.toString());
  }

  /*栄養素の合計値の塊作成*/
  void addMenuNutrient() {
    _dailyMenuNutrient.add(_menus[firstDay].menuEnergy.toString() + ' kcal');
    _dailyMenuNutrient.add(_menus[firstDay].menuProtein.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuLipid.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuCarbohydrate.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuSodium.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuCalcium.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuMagnesium.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuIron.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuZinc.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuRetinol.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuVitaminB1.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuVitaminB2.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuVitaminC.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuDietaryFiber.toString() + ' g');
    _dailyMenuNutrient.add(_menus[firstDay].menuSalt.toString() + ' g');
  }

  /*カテゴリー表示*/
  Widget todayCategory(String category) {
    return Container(
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Text(category, style: TextStyle(fontSize: 25)),
    );
  }

  /*メニュー名表示*/
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

  /*栄養素の合計値表示*/
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
          subtitle: Text(_dailyMenuNutrient[i].toString()),
        ),
      )
    );
  }

  /*栄養素の合計値をグラフ表示*/
  Widget dailyMenuNutrientGraph() {
    return Center(
        child: Container(
          padding: EdgeInsets.only(top: 20,bottom: 20),
          width: 300,
          height: 300,
          child: SpiderChart(
            data: [
              7,
              5,
              10,
              7,
              4,
            ],
            maxValue: 100,
            colors: <Color>[
              Colors.red,
              Colors.green,
              Colors.blue,
              Colors.yellow,
              Colors.indigo,
            ],
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    addMenuNutrient();
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
              children: <Widget>[dailyMenuNameList()
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
          ),
          dailyMenuNutrientGraph(),
        ],
      ),
    );
  }
}
