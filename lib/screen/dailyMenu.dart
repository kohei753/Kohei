import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:multi_charts/multi_charts.dart';

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/screen/detail.dart';
import 'package:sample/data/dri.dart';

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
  ScrollController _controller = new ScrollController();
  Menu menu; //引き継いでる変数を移すための変数
  Child child;
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
  DRI dri;

  /*読み込まれた時に遷移されてきた変数を代入*/
  @override
  void initState() {
    super.initState();
    menu = widget.menu;
    child = widget.child;
    dri = widget.dri;
  }

  /*グラフ用栄養素の作成*/
  double get graphProteinPercentage {
    var graphProtein = 0.0;
    var result = 0.0;
    graphProtein = menu.menuProtein; //摂取タンパク質
    result = (graphProtein / dri.getNutrient(child)["protein"]) * 100; // (摂取タンパク質/推奨タンパク質)*100
    return result;
  }

  double get graphVitaminPercentage {
    var graphRetinol = menu.menuRetinol / dri.getNutrient(child)["retinol"] * 100;
    var graphVitaminB1 = menu.menuVitaminB1 / dri.getNutrient(child)["vitaminB1"] * 100;
    var graphVitaminB2 = menu.menuVitaminB2 / dri.getNutrient(child)["vitaminB2"] * 100;
    var graphVitaminC = menu.menuVitaminC / dri.getNutrient(child)["vitaminC"] * 100;
    var result =
        (graphRetinol + graphVitaminB1 + graphVitaminB2 + graphVitaminC) / 4;
    return result;
  }

  double get graphMineralPercentage {
    var graphCalcium = menu.menuCalcium / dri.getNutrient(child)["calcium"] * 100;
    var graphIron = menu.menuIron / dri.getNutrient(child)["iron"] * 100;
    var graphMagnesium = menu.menuMagnesium / dri.getNutrient(child)["magnesium"] * 100;
    var graphZinc = menu.menuZinc / dri.getNutrient(child)["zinc"] * 100;
    var result = (graphCalcium +
            graphIron +
            graphMagnesium +
            graphZinc) / 4;
    return result;
  }

  double get graphCarbohydratePercentage {
    var graphCarbohydrate = menu.menuCarbohydrate / dri.getNutrient(child)["carbohydrate"] *100;
    var graphDietaryFiber = menu.menuDietaryFiber / dri.getNutrient(child)["dietaryFiber"] * 100;
    var result = (graphCarbohydrate + graphDietaryFiber) /  2;
    return result;
  }

  double get graphLipidPercentage {
    var graphLipid = 0.0;
    var result = 0.0;
    graphLipid =
        menu.menuLipid / dri.getNutrient(child)["lipid"] * 100 ; //脂肪エネルギー比率＝((脂質*9)／総エネルギー)×100
    if(graphLipid >= 100) {
      graphLipid = 100;
    }
    result = graphLipid; // (摂取した脂肪エネルギー比率/推奨脂肪エネルギー比率)*100
    return result;
  }

  /*グラフ用の%数値の作成*/
  void judgeChild() {
    dri.getNutrient(child);
    print(dri.getNutrient(child));
    print(menu.menuLipid);
  }

  /*献立コンソール表示*/
  void testMenuName() {
    for (int i = 0; i < menu.menu.length; i++) {
      print(menu.menu[i].name);
    }
  }

  /*栄養素の合計値の塊作成*/
  void addMenuNutrient() {
    _dailyMenuNutrient.add(menu.menuEnergy.toStringAsFixed(2) + ' kcal');
    _dailyMenuNutrient.add(menu.menuProtein.toStringAsFixed(2) + ' g');
    _dailyMenuNutrient.add(menu.menuLipid.toStringAsFixed(2) + ' g');
    _dailyMenuNutrient.add(menu.menuCarbohydrate.toStringAsFixed(2) + ' g');
    _dailyMenuNutrient.add(menu.menuSodium.toStringAsFixed(2) + ' mg');
    _dailyMenuNutrient.add(menu.menuCalcium.toStringAsFixed(2) + ' mg');
    _dailyMenuNutrient.add(menu.menuMagnesium.toStringAsFixed(2) + ' mg');
    _dailyMenuNutrient.add(menu.menuIron.toStringAsFixed(2) + ' mg');
    _dailyMenuNutrient.add(menu.menuZinc.toStringAsFixed(2) + ' mg');
    _dailyMenuNutrient.add(menu.menuRetinol.toStringAsFixed(2) + ' µg');
    _dailyMenuNutrient.add(menu.menuVitaminB1.toStringAsFixed(2) + ' mg');
    _dailyMenuNutrient.add(menu.menuVitaminB2.toStringAsFixed(2) + ' mg');
    _dailyMenuNutrient.add(menu.menuVitaminC.toStringAsFixed(2) + ' mg');
    _dailyMenuNutrient.add(menu.menuDietaryFiber.toStringAsFixed(2) + ' g');
    _dailyMenuNutrient.add(menu.menuSalt.toStringAsFixed(2) + ' g');
  }

  void handleToDetail(int x) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/detail'),
        builder: (BuildContext context) => Detail(
          dailyMenu: menu,
          child: child,
          menuNum: x,
        ),
      ),
    );
  }

  /*カテゴリー表示*/
  Widget todayCategory(String category) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Text(category, style: TextStyle(fontSize: 25)),
    );
  }

  /*メニュー名表示*/
  Widget dailyMenuNameList() {
    return Column(
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(menu.menu.length, (int i) {
            return InputChip(
              label: Text(menu.menu[i].name),
              onPressed: () {
                handleToDetail(i);
              },
            );
          }),
        ),
      ],
    );
  }

  /*栄養素の合計値表示*/
  Widget dailyMenuNutrientList() {
    return Column(
        children: List.generate(dailyMenuName.length, (int i) {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Text(dailyMenuName[i]),
                ),
                Expanded(
                  flex: 3,
                  child: Text(_dailyMenuNutrient[i]),
                ),
              ],
            ),
            Divider(color: Colors.black),
          ],
        ),
      );
    }));
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
    judgeChild();
    addMenuNutrient();
//    testMenuName();
    // TODO: implement build
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _controller,
      children: <Widget>[
        todayCategory("料理名"),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: dailyMenuNameList(),
        ),
        todayCategory("栄養素"),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Column(
            children: <Widget>[dailyMenuNutrientList()],
          ),
        ),
        dailyMenuNutrientGraph(size.width * 0.65, size.height * 0.65),
      ],
    );
  }
}
