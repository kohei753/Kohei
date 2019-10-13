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
  final Map<String, double> myChildDRI;
  Detail({Key key, this.dailyMenu, this.child, this.dri, this.menuNum, this.myChildDRI}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  /* 諸々データ */
  Menu _dailyMenu; // 表示する日のメニューデータ
  Child _child;
  DRI _dri;
  Map<String, double> _myChildDRI;
  var formatter = DateFormat("yyyy/MM/dd(E)"); // 日付をフォーマットするやつ
  /*スクロール可能なコントローラ作成*/
  ScrollController _controller = new ScrollController();
  var _dishNutrient = [];
  /*それぞれの栄養素の名前*/
  var _nutrientName = [
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
  double get graphDishProtein {
    double graphProtein = _dailyMenu.menu[_selectedIndex].dishProtein / _myChildDRI["protein"]  * 100;
    double result = graphProtein;
    return result;
  }

  double get graphDishVitamin {
    double graphRetinol = _dailyMenu.menu[_selectedIndex].dishRetinol / _myChildDRI["retinol"] * 100;
    double graphVitaminB1 = _dailyMenu.menu[_selectedIndex].dishVitaminB1 / _myChildDRI["vitaminB1"] * 100;
    double graphVitaminB2 = _dailyMenu.menu[_selectedIndex].dishVitaminB2 / _myChildDRI["vitaminB2"] * 100;
    double graphVitaminC = _dailyMenu.menu[_selectedIndex].dishVitaminC / _myChildDRI["vitaminC"] * 100;
    double result =
        (graphRetinol + graphVitaminB1 + graphVitaminB2 + graphVitaminC) / 4;
    return result;
  }

  double get graphDishMineral {
    double graphCalcium = _dailyMenu.menu[_selectedIndex].dishCalcium / _myChildDRI["calcium"] * 100;
    double graphIron = _dailyMenu.menu[_selectedIndex].dishIron / _myChildDRI["iron"] * 100;
    double graphMagnesium = _dailyMenu.menu[_selectedIndex].dishMagnesium / _myChildDRI["magnesium"] * 100;
    double graphZinc = _dailyMenu.menu[_selectedIndex].dishZinc / _myChildDRI["zinc"] * 100;
    double result = (graphCalcium +
        graphIron +
        graphMagnesium +
        graphZinc) / 4;
    return result;
  }

  double get graphDishCarbohydrate {
    double graphCarbohydrate = _dailyMenu.menu[_selectedIndex].dishCarbohydrate / _myChildDRI["carbohydrate"] *100;
    double graphDietaryFiber = _dailyMenu.menu[_selectedIndex].dishDietaryFiber / _myChildDRI["dietaryFiber"] * 100;
    double result = (graphCarbohydrate + graphDietaryFiber) /  2;
    return result;
  }

  double get graphDishLipid {
    double graphLipid = _dailyMenu.menu[_selectedIndex].dishLipid / _myChildDRI["lipid"] * 100 ; //脂肪エネルギー比率＝((脂質*9)／総エネルギー)×100
    if(graphLipid >= 100) {
      graphLipid = 100;
    }
    double result = graphLipid; // (摂取した脂肪エネルギー比率/推奨脂肪エネルギー比率)*100
    return result;
  }

  /* 読み込まれた時にデータを取得する */
  @override
  void initState() {
    super.initState();
    _dailyMenu = widget.dailyMenu;
    _child = widget.child;
    _dri = widget.dri;
    _myChildDRI = widget.myChildDRI;
    if (widget.menuNum != null) _selectedIndex = widget.menuNum;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _dishNutrient = [];
    });
  }

  void addDishNutrient() {
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishEnergy.toStringAsFixed(2) + ' kcal');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishProtein.toStringAsFixed(2) + ' g');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishLipid.toStringAsFixed(2) + ' g');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishCarbohydrate.toStringAsFixed(2) + ' g');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishSodium.toStringAsFixed(2) + ' mg');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishCalcium.toStringAsFixed(2) + ' mg');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishMagnesium.toStringAsFixed(2) + ' mg');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishIron.toStringAsFixed(2) + ' mg');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishZinc.toStringAsFixed(2) + ' mg');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishRetinol.toStringAsFixed(2) + ' µg');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishVitaminB1.toStringAsFixed(2) + ' mg');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishVitaminB2.toStringAsFixed(2) + ' mg');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishVitaminC.toStringAsFixed(2) + ' mg');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishDietaryFiber.toStringAsFixed(2) + ' g');
    _dishNutrient.add(_dailyMenu.menu[_selectedIndex].dishSalt.toStringAsFixed(2) + ' g');
  }

  /*カテゴリー表示*/
  Widget titleBar(String category) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      width: double.infinity,
      color: _detailColors[_selectedIndex], //選択された料理名になる
      child: Text(category, style: TextStyle(fontSize: 25)),
    );
  }

  /*材料名表示*/
  Widget materialList() {
    return Column(
        children: List.generate(_dailyMenu.menu[_selectedIndex].dish.length, (int i) { //選択した料理名の材料のリスト表示
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(_dailyMenu.menu[_selectedIndex].dish[i].name), //材料名を表示
                  ],
                ),
                Divider(color: Colors.black), //下線
              ],
            ),
          );
        }));
  }

  /*栄養素の合計値表示*/
  Widget dishNutrientList() {
    return Column(
        children: List.generate(_nutrientName.length, (int i) { //下の線を含めてリスト作成
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Text(_nutrientName[i]), //栄養素の名前
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(_dishNutrient[i]), //料理の栄養素
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
  Widget dailyDishNutrientGraph(double deviceWidth, double deviceHeight) {
    return Center(
      child: Container(
        width: deviceWidth, //ここがグラフの横幅を管理する
        height: deviceHeight, //ここがグラフの縦幅を管理する
        child: RadarChart(
          values: [
            graphDishProtein,
            graphDishLipid,
            graphDishCarbohydrate,
            graphDishVitamin,
            graphDishMineral
          ],
          labels: [
            "タンパク質\n(" + graphDishProtein.toStringAsFixed(0) + "％)",
            "脂質\n(" + graphDishLipid.toStringAsFixed(0) + "％)",
            "炭水化物\n(" + graphDishCarbohydrate.toStringAsFixed(0) + "％)",
            "ビタミン\n(" + graphDishVitamin.toStringAsFixed(0) + "％)",
            "ミネラル\n(" + graphDishMineral.toStringAsFixed(0) + "％)",
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
        physics: const AlwaysScrollableScrollPhysics(), //コンテンツが不十分な場合でも常にスクロール可能
        controller: _controller, //スクロールできるようになる
        children: <Widget>[
          titleBar("材料"),
          Container(
            padding: EdgeInsets.all(10),
            child: materialList() //材料表示
          ),
          titleBar("栄養素"),
          Container(
              padding: EdgeInsets.only(top: 10, bottom: 10,left: 10),
              child: dishNutrientList() //栄養素表示
          ),
          dailyDishNutrientGraph(size.width * 0.65, size.height * 0.65) //グラフの縦幅と横幅は65%
        ],
      )
    );
  }
}
