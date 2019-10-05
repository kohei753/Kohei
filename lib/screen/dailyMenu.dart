import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'detail.dart';
import 'package:multi_charts/multi_charts.dart';

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/screen/detail.dart';

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
//  Menu menuList = _menus[DateTime(2019, 8, 19)];
  ScrollController _controller = new ScrollController();
  Child _child;
  static var firstDay = DateTime(2019, 8, 19); //デバック用
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
  double get graphProteinPercentage {
    var graphProtein = 0.0;
    var result = 0.0;
    graphProtein = _menus[firstDay].menuProtein; //摂取タンパク質
    result = (graphProtein / 60) * 100; // (摂取タンパク質/推奨タンパク質)*100
    return result;
  }

  double get graphVitaminPercentage {
    var graphRetional = _menus[firstDay].menuRetinol / 800 * 100;
    var graphVitaminB1 = _menus[firstDay].menuVitaminB1 / 1.4 * 100;
    var graphVitaminB2 = _menus[firstDay].menuVitaminB2 / 1.6 * 100;
    var graphVitaminC = _menus[firstDay].menuVitaminC / 95 * 100;
    var result =
        (graphRetional + graphVitaminB1 + graphVitaminB2 + graphVitaminC) / 4;
    return result;
  }

  double get graphMineralPercentage {
    var graphCalcium = _menus[firstDay].menuCalcium / 1000 * 100;
    var graphSodium = _menus[firstDay].menuSodium / 1000 / 8 * 100;
    var graphIron = _menus[firstDay].menuIron / 11.5 * 100;
    var graphMagnesium = _menus[firstDay].menuMagnesium / 290 * 100;
    var graphZinc = _menus[firstDay].menuZinc / 9 * 100;
    var graphSalt = _menus[firstDay].menuSalt / 8 * 100;
    var result = (graphCalcium +
            graphSodium +
            graphIron +
            graphMagnesium +
            graphZinc +
            graphSalt) /
        6;
    return result;
  }

  double get graphCarbohydratePercentage {
    var graphCarbohydrate = _menus[firstDay].menuCarbohydrate *
        4 /
        2600 *
        100; //((炭水化物エネルギー比率=炭水化物*4)/総エネルギー)×100
    var graphDietaryFiber = _menus[firstDay].menuDietaryFiber;
    var result =
        ((graphCarbohydrate / 60 * 100) + (graphDietaryFiber / 17 * 100)) / 2;
    return result;
  }

  double get graphLipidPercentage {
    var graphLipid = 0.0;
    var result = 0.0;
    graphLipid = _menus[firstDay].menuLipid *
        9 /
        2600 *
        100; //脂肪エネルギー比率＝((脂質*9)／総エネルギー)×100
    result = (graphLipid / 25) * 100; // (摂取した脂肪エネルギー比率/推奨脂肪エネルギー比率)*100
    return result;
  }

  /*グラフ用の%数値の作成*/
  void judgeChild() {
    print(_child.name);
    print(_child.school);
    print(_child.schoolYear);
    print(_child.sex);
    if (_child.sex == "men") {
      if (_child.schoolYear == 7) {
      } else {}
    } else {}
  }

  /*献立コンソール表示*/
  void testMenuName() {
    for (int i = 0; i < _menus[firstDay].menu.length; i++) {
      print(_menus[firstDay].menu[i].name);
    }
  }

  /*栄養素コンソール表示*/
  void testMenuNutrient() {
    print('タンパク質: ' + graphProteinPercentage.toString());
    print('ビタミン: ' + graphVitaminPercentage.toString());
    print('ミネラル: ' + graphMineralPercentage.toString());
    print('炭水化物: ' + graphCarbohydratePercentage.toString());
    print('脂質: ' + graphLipidPercentage.toString());
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

  void _handleDetail() {
    // 詳細画面へ
    Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/detail'),
          builder: (BuildContext context) => Detail(),
        ));
  }

  /*カテゴリー表示*/
  Widget todayCategory(String category) {
    return Container(
      padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Text(category, style: TextStyle(fontSize: 25)),
    );
  }

  /*メニュー名表示*/
  Widget dailyMenuNameList() {
    return Column(
        children: List.generate(_menus[firstDay].menu.length, (int i) {
      return InputChip(
        label: Text(_menus[firstDay].menu[i].name),
        onPressed: _handleDetail,
      );
    }));
  }

  /*栄養素の合計値表示*/
  Widget dailyMenuNutrientList() {
    return Column(
        children: List.generate(dailyMenuName.length, (int i) {
          return Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(dailyMenuName[i]),
                  subtitle: Text(_dailyMenuNutrient[i].toString()),
                ),
                Divider(color: Colors.black),
              ],
            ),
          );
        })
    );
  }

  /*栄養素をグラフ表示*/
  Widget dailyMenuNutrientGraph(double x, double y) {
    return Center(
      child: Container(
        width: x,
        height: y,
        child: RadarChart(
          values: [
            graphProteinPercentage,
            graphLipidPercentage,
            graphCarbohydratePercentage,
            graphVitaminPercentage,
            graphMineralPercentage,
          ],
          labels: [
            "タンパク質\n(" + graphProteinPercentage.toStringAsFixed(0) + "％)",
            "脂質\n(" + graphLipidPercentage.toStringAsFixed(0) + "％)",
            "炭水化物\n(" + graphCarbohydratePercentage.toStringAsFixed(0) + "％)",
            "ビタミン\n(" + graphVitaminPercentage.toStringAsFixed(0) + "％)",
            "ミネラル\n(" + graphMineralPercentage.toStringAsFixed(0) + "％)",
          ],
          maxValue: 100,
          fillColor: Colors.orange,
          animate: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
//    judgeChild();
    addMenuNutrient();
//    testMenuName();
    testMenuNutrient();
    // TODO: implement build
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _controller,
      children: <Widget>[
        todayCategory("料理名"),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[dailyMenuNameList()],
          ),
        ),
        todayCategory("栄養素"),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[dailyMenuNutrientList()],
          ),
        ),
        dailyMenuNutrientGraph(size.width*0.65, size.height*0.65),
      ]
    );
  }

}
