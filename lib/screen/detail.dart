import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:intl/intl.dart';  // DateTimeのフォーマットに使う
import 'package:multi_charts/multi_charts.dart';

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';

/* 詳細画面 */
class Detail extends StatefulWidget {
  final Menu dailyMenu;
  final Child child;
  final DRI dri;
  final int menuNum;  // 選択されたメニューの番号
  Detail({Key key, this.dailyMenu, this.child, this.dri, this.menuNum}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  /* 諸々データ */
  Menu _dailyMenu; // 表示する日のメニューデータ
  Child child;
  DRI dri;
  var formatter = DateFormat("yyyy/MM/dd(E)"); // 日付をフォーマットするやつ

  ScrollController _controller = new ScrollController();
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
  var _detailDishNutrient = [];

  /* サイドバー関係 */
  int _selectedIndex = 0; // 選択中のタブ番号管理

  /* カラーリスト */
  List<Color> _detailColors = [
    Color(0xFFf6f183),
    Color(0xFF82c1f5),
    Color(0xFF87f582),
    Color(0xFFf58287),
    Color(0xFFffba66),
    Color(0xFFb682f5),
  ];

  /* サイドバーの各メニューのアイコン
  *  色が上のカラーリストと対応している */
  List<String> _menuIcon = [
    'assets/staple.png',
    'assets/drink.png',
    'assets/side_green.png',
    'assets/side_red.png',
    'assets/side_orenge.png',
    'assets/side_purple.png',
  ];

  /*グラフ用栄養素の作成*/
  double get graphDetailProtein {
    var graphProtein = 0.0;
    var result = 0.0;
    graphProtein = _dailyMenu.menu[_selectedIndex].dishProtein / dri.getNutrient(child)["protein"]; //摂取タンパク質
    result = graphProtein * 100;
    return result;
  }

  double get graphDetailVitamin {
    var graphRetinol = _dailyMenu.menu[_selectedIndex].dishRetinol / dri.getNutrient(child)["retinol"] * 100;
    var graphVitaminB1 = _dailyMenu.menu[_selectedIndex].dishVitaminB1 / dri.getNutrient(child)["vitaminB1"] * 100;
    var graphVitaminB2 = _dailyMenu.menu[_selectedIndex].dishVitaminB2 / dri.getNutrient(child)["vitaminB2"] * 100;
    var graphVitaminC = _dailyMenu.menu[_selectedIndex].dishVitaminC / dri.getNutrient(child)["vitaminC"] * 100;
    var result =
        (graphRetinol + graphVitaminB1 + graphVitaminB2 + graphVitaminC) / 4;
    return result;
  }

  double get graphDetailMineral {
    var graphCalcium = _dailyMenu.menu[_selectedIndex].dishCalcium / dri.getNutrient(child)["calcium"] * 100;
    var graphIron = _dailyMenu.menu[_selectedIndex].dishIron / dri.getNutrient(child)["iron"] * 100;
    var graphMagnesium = _dailyMenu.menu[_selectedIndex].dishMagnesium / dri.getNutrient(child)["magnesium"] * 100;
    var graphZinc = _dailyMenu.menu[_selectedIndex].dishZinc / dri.getNutrient(child)["zinc"] * 100;
    var result = (graphCalcium +
        graphIron +
        graphMagnesium +
        graphZinc) / 4;
    return result;
  }

  double get graphDetailCarbohydrate {
    var graphCarbohydrate = _dailyMenu.menu[_selectedIndex].dishCarbohydrate / dri.getNutrient(child)["carbohydrate"] *100;
    var graphDietaryFiber = _dailyMenu.menu[_selectedIndex].dishDietaryFiber / dri.getNutrient(child)["dietaryFiber"] * 100;
    var result = (graphCarbohydrate + graphDietaryFiber) /  2;
    return result;
  }

  double get graphDetailLipid {
    var graphLipid = 0.0;
    graphLipid = _dailyMenu.menu[_selectedIndex].dishLipid / dri.getNutrient(child)["lipid"] * 100 ; //脂肪エネルギー比率＝((脂質*9)／総エネルギー)×100
    if(graphLipid >= 100) {
      graphLipid = 100;
    }
    var result = graphLipid; // (摂取した脂肪エネルギー比率/推奨脂肪エネルギー比率)*100
    return result;
  }

  /* 読み込まれた時にデータを取得する */
  @override
  void initState() {
    super.initState();
    _dailyMenu = widget.dailyMenu;
    child = widget.child;
    dri = widget.dri;
    if (widget.menuNum != null) _selectedIndex = widget.menuNum;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _detailDishNutrient = [];
    });
  }

  void addDishNutrient() {
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishEnergy.toStringAsFixed(2) + ' kcal');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishProtein.toStringAsFixed(2) + ' g');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishLipid.toStringAsFixed(2) + ' g');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishCarbohydrate.toStringAsFixed(2) + ' g');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishSodium.toStringAsFixed(2) + ' mg');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishCalcium.toStringAsFixed(2) + ' mg');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishMagnesium.toStringAsFixed(2) + ' mg');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishIron.toStringAsFixed(2) + ' mg');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishZinc.toStringAsFixed(2) + ' mg');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishRetinol.toStringAsFixed(2) + ' µg');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishVitaminB1.toStringAsFixed(2) + ' mg');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishVitaminB2.toStringAsFixed(2) + ' mg');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishVitaminC.toStringAsFixed(2) + ' mg');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishDietaryFiber.toStringAsFixed(2) + ' g');
    _detailDishNutrient.add(_dailyMenu.menu[_selectedIndex].dishSalt.toStringAsFixed(2) + ' g');
  }

  /*カテゴリー表示*/
  Widget detailCategory(String category) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Text(category, style: TextStyle(fontSize: 25)),
    );
  }

  /*材料名表示*/
  Widget detailNameList() {
    return Column(
        children: List.generate(_dailyMenu.menu[_selectedIndex].dish.length, (int i) {
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(_dailyMenu.menu[_selectedIndex].dish[i].name),
                  ],
                ),
                Divider(color: Colors.black),
              ],
            ),
          );
        }));
  }

  /*栄養素の合計値表示*/
  Widget detailNutrientList() {
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
                      child: Text(_detailDishNutrient[i]),
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
  Widget dailyDishNutrientGraph(double x, double y) {
    return Center(
      child: Container(
        width: x,
        height: y,
        child: RadarChart(
          values: [
            graphDetailProtein,
            graphDetailLipid,
            graphDetailCarbohydrate,
            graphDetailVitamin,
            graphDetailMineral
          ],
          labels: [
            "タンパク質\n(" + graphDetailProtein.toStringAsFixed(0) + "％)",
            "脂質\n(" + graphDetailLipid.toStringAsFixed(0) + "％)",
            "炭水化物\n(" + graphDetailCarbohydrate.toStringAsFixed(0) + "％)",
            "ビタミン\n(" + graphDetailVitamin.toStringAsFixed(0) + "％)",
            "ミネラル\n(" + graphDetailMineral.toStringAsFixed(0) + "％)",
          ],
          maxValue: 100,
          fillColor: Colors.orange,
          animate: false,
        ),
      ),
    );
  }

  /* サイドメニューを生成 */
  Widget _buildDrawer() {
    return Drawer(
      child: ListView.builder(
        // 中身はリスト表示
        padding: EdgeInsets.zero, // 余白を消去
        itemCount: _dailyMenu.menu.length + 1, // +1はヘッダーを作成するため
        itemBuilder: (context, i) {
          if (i == 0) return _buildDrawerHeader(); // 一番上にヘッダーを作成
          final index = i - 1; // ヘッダーを抜いた真のindex
          return ListTile(
            leading: Image.asset(
              // メニューの横のアイコン
              _menuIcon[index],
              width: 50,
              height: 50,
            ),
            title: Text(_dailyMenu.menu[index].name), // とりあえず名前だしてるだけ
            onTap: () => _onItemTapped(index), // タップしたら切り替えるように
          );
        },
      ),
    );
  }

  /* サイドメニューのヘッダー */
  Widget _buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(
        // メニュー名
        _dailyMenu.menu[_selectedIndex].name,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 20, // ちょっと大きめに
        ),
      ),
      accountEmail: Text(
        // 日付
        formatter.format(_dailyMenu.day),
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        // 画像
        backgroundColor: Colors.black26,
        child: Image.asset(_menuIcon[_selectedIndex]),
      ),
      decoration: BoxDecoration(
        color: _detailColors[_selectedIndex], // 背景色も変えられるよ
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    addDishNutrient();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _dailyMenu.menu[_selectedIndex].name,
          style: TextStyle(color: Colors.black54),
        ), // 選択した料理名に
        backgroundColor: _detailColors[_selectedIndex],
      ),
      endDrawer: _buildDrawer(), // サイドメニュー
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          detailCategory("料理名"),
          Container(
            padding: EdgeInsets.all(10),
            child: detailNameList()
          ),
          detailCategory("栄養素"),
          Container(
              padding: EdgeInsets.only(top: 10, bottom: 10,left: 10),
              child: detailNutrientList()
          ),
          dailyDishNutrientGraph(size.width * 0.65, size.height * 0.65)
        ],
      )
    );
  }
}
