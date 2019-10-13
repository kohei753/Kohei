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
  /*スクロール可能なコントローラ作成*/
  ScrollController _controller;

  /*引き継いでる変数を移すための変数*/
  Menu _menu;
  static Child _child;
  static DRI _dri;
  Map<String, double> _myChildDRI; //子供に合わせた基準栄養素

  /*それぞれの栄養素の名前*/
  List<String> _nutrientName = [
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

  /*メニューの栄養素*/
  var _menuNutrient = [];

  /*読み込まれた時に遷移されてきた変数を代入*/
  @override
  void initState() {
    super.initState();
    _menu = widget.menu;
    _child = widget.child;
    _dri = widget.dri;
    _myChildDRI =  _dri.getNutrient(_child);
  }

  /*グラフ用栄養素の作成*/
  /*タンパク質*/
  double get _graphMenuProtein {
    double graphProtein = _menu.menuProtein / _myChildDRI["protein"] * 100; //摂取タンパク質
    double result = graphProtein;
    return result;
  }
  /*ビタミン*/
  double get _graphMenuVitamin {
    double graphRetinol = _menu.menuRetinol / _myChildDRI["retinol"] * 100;
    double graphVitaminB1 = _menu.menuVitaminB1 / _myChildDRI["vitaminB1"] * 100;
    double graphVitaminB2 = _menu.menuVitaminB2 / _myChildDRI["vitaminB2"] * 100;
    double graphVitaminC = _menu.menuVitaminC / _myChildDRI["vitaminC"] * 100;
    double result =
        (graphRetinol + graphVitaminB1 + graphVitaminB2 + graphVitaminC) / 4;
    return result;
  }
  /*ミネラル*/
  double get _graphMenuMineral {
    double graphCalcium = _menu.menuCalcium / _myChildDRI["calcium"] * 100;
    double graphIron = _menu.menuIron / _myChildDRI["iron"] * 100;
    double graphMagnesium = _menu.menuMagnesium / _myChildDRI["magnesium"] * 100;
    double graphZinc = _menu.menuZinc / _myChildDRI["zinc"] * 100;
    double result = (graphCalcium +
            graphIron +
            graphMagnesium +
            graphZinc) / 4;
    return result;
  }
  /*炭水化物*/
  double get _graphMenuCarbohydrate {
    double graphCarbohydrate = _menu.menuCarbohydrate / _myChildDRI["carbohydrate"] *100;
    double graphDietaryFiber = _menu.menuDietaryFiber / _myChildDRI["dietaryFiber"] * 100;
    double result = (graphCarbohydrate + graphDietaryFiber) /  2;
    return result;
  }
  /*脂質*/
  double get _graphMenuLipid {
    double graphLipid = _menu.menuLipid / _myChildDRI["lipid"] * 100 ;
    if(graphLipid >= 100) { //脂質が100%を越えるためここで制御
      graphLipid = 100;
    }
    double result = graphLipid;
    return result;
  }

  /*栄養素の合計値の塊作成*/
  void addMenuNutrient() {
    _menuNutrient.add(_menu.menuEnergy.toStringAsFixed(2) + ' kcal');
    _menuNutrient.add(_menu.menuProtein.toStringAsFixed(2) + ' g');
    _menuNutrient.add(_menu.menuLipid.toStringAsFixed(2) + ' g');
    _menuNutrient.add(_menu.menuCarbohydrate.toStringAsFixed(2) + ' g');
    _menuNutrient.add(_menu.menuSodium.toStringAsFixed(2) + ' mg');
    _menuNutrient.add(_menu.menuCalcium.toStringAsFixed(2) + ' mg');
    _menuNutrient.add(_menu.menuMagnesium.toStringAsFixed(2) + ' mg');
    _menuNutrient.add(_menu.menuIron.toStringAsFixed(2) + ' mg');
    _menuNutrient.add(_menu.menuZinc.toStringAsFixed(2) + ' mg');
    _menuNutrient.add(_menu.menuRetinol.toStringAsFixed(2) + ' µg');
    _menuNutrient.add(_menu.menuVitaminB1.toStringAsFixed(2) + ' mg');
    _menuNutrient.add(_menu.menuVitaminB2.toStringAsFixed(2) + ' mg');
    _menuNutrient.add(_menu.menuVitaminC.toStringAsFixed(2) + ' mg');
    _menuNutrient.add(_menu.menuDietaryFiber.toStringAsFixed(2) + ' g');
    _menuNutrient.add(_menu.menuSalt.toStringAsFixed(2) + ' g');
    print(_dri.getNutrient);
  }

  /*詳細画面に値と画面遷移*/
  void handleToDetail(int selectIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/detail'),
        builder: (BuildContext context) => Detail(
          dri: _dri,
          dailyMenu: _menu,
          child: _child,
          menuNum: selectIndex, //選んだ数字を遷移させることで料理毎の処理を可能
          myChildDRI: _myChildDRI,
        ),
      ),
    );
  }

  /*タイトルバー表示*/
  Widget titleBar(String category) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      width: double.infinity, //画面いっぱいに出すよ
      color: Colors.orangeAccent,
      child: Text(category, style: TextStyle(fontSize: 25)),
    );
  }

  /*メニュー名表示*/
  Widget menuNameList() {
    return Column(
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(_menu.menu.length, (int i) {
            return InputChip(
              label: Text(_menu.menu[i].name), //今日のメニューを表示する
              onPressed: () {
                handleToDetail(i); //(i)番目の料理名のChipクリックで詳細画面に遷移
              },
            );
          }),
        ),
      ],
    );
  }

  /*栄養素の合計値リスト表示*/
  Widget menuNutrientList() {
    return Column(
        children: List.generate(_nutrientName.length, (int i) { //栄養素の名前、数値、線を一つにまとめてリストにしている
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
                  child: Text(_menuNutrient[i]), //栄養素の数値
                ),
              ],
            ),
            Divider(color: Colors.black), // 下の線を実装してる
          ],
        ),
      );
    }));
  }

  /*栄養素をグラフ表示*/
  Widget menuGraph(double deviceWidth, double deviceHeight) {
    return Center(
      child: Container(
        width: deviceWidth, //コンテイナーの横幅を変数指定
        height: deviceHeight, //コンテイナーの縦幅を変数指定
        child: RadarChart( //レーダーチャート
          values: [
            _graphMenuProtein,
            _graphMenuLipid,
            _graphMenuCarbohydrate,
            _graphMenuVitamin,
            _graphMenuMineral,
          ],
          labels: [ //今回は文字だけでなく、%も可変にしている
            "タンパク質\n(" + _graphMenuProtein.toStringAsFixed(0) + "％)",
            "脂質\n(" + _graphMenuLipid.toStringAsFixed(0) + "％)",
            "炭水化物\n(" + _graphMenuCarbohydrate.toStringAsFixed(0) + "％)",
            "ビタミン\n(" + _graphMenuVitamin.toStringAsFixed(0) + "％)",
            "ミネラル\n(" + _graphMenuMineral.toStringAsFixed(0) + "％)",
          ],
          maxValue: 100, //グラフの最大値は100
          fillColor: Colors.orange, //グラフの色はオレンジで塗ります
          animate: false, //アニメーションはつけない
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size; //デバイス毎のサイズを持ってくる(縦幅と横幅両方)
    addMenuNutrient(); //ここで栄養素の塊作成
    // TODO: implement build
    return ListView( //リストで並べる
      physics: const AlwaysScrollableScrollPhysics(), //コンテンツが不十分な場合でも常にスクロール可能
      controller: _controller, //スクロール可能なウィジェットになる
      children: <Widget>[
        titleBar("料理名"),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: menuNameList(), //メニューの名前表示
        ),
        titleBar("栄養素"),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Column(
            children: <Widget>[
              menuNutrientList() //栄養素表示
            ],
          ),
        ),
        menuGraph(_size.width * 0.65, _size.height * 0.65), //グラフの縦幅と横幅は65%
      ],
    );
  }
}
