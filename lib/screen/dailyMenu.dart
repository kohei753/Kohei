import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:multi_charts/multi_charts.dart';

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'package:sample/data/strings.dart';
import 'package:sample/screen/detail.dart';

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
  /* 引き継いでる変数を移すための変数 */
  Menu menu;
  Child child;
  DRI dri;

  /* この画面内でのみ使う変数 */
  bool _isMenu; // 今日のメニューがあるか
  ScrollController _controller; // スクロールできるようにする
  Map<String, double> _myChildDRI; // 子供に合わせた基準栄養素

  /* それぞれの栄養素の名前と値・単位 */
  final List<String> _nutrientName = MenuStrings.nutrientName;
  Map<String, double> _nutrientValue;
  final Map<String, String> _units = MenuStrings.units;

  /* 読み込まれた時に遷移されてきた変数を代入 */
  @override
  void initState() {
    super.initState();
    menu = widget.menu;
    child = widget.child;
    dri = widget.dri;

    _isMenu = (menu != null) ? true : false;
    _myChildDRI = dri.getNutrient(child);
    if (_isMenu) {
      // メニューがない場合空の値を代入し、存在する場合はその日の献立の栄養素合計値を代入
      _nutrientValue = {
        _nutrientName[0]: menu.menuEnergy,
        _nutrientName[1]: menu.menuProtein,
        _nutrientName[2]: menu.menuLipid,
        _nutrientName[3]: menu.menuCarbohydrate,
        _nutrientName[4]: menu.menuSodium,
        _nutrientName[5]: menu.menuCalcium,
        _nutrientName[6]: menu.menuMagnesium,
        _nutrientName[7]: menu.menuIron,
        _nutrientName[8]: menu.menuZinc,
        _nutrientName[9]: menu.menuRetinol,
        _nutrientName[10]: menu.menuVitaminB1,
        _nutrientName[11]: menu.menuVitaminB2,
        _nutrientName[12]: menu.menuVitaminC,
        _nutrientName[13]: menu.menuDietaryFiber,
        _nutrientName[14]: menu.menuSalt,
      };
    } else {
      _nutrientValue = {
        _nutrientName[0]: 0.0,
        _nutrientName[1]: 0.0,
        _nutrientName[2]: 0.0,
        _nutrientName[3]: 0.0,
        _nutrientName[4]: 0.0,
        _nutrientName[5]: 0.0,
        _nutrientName[6]: 0.0,
        _nutrientName[7]: 0.0,
        _nutrientName[8]: 0.0,
        _nutrientName[9]: 0.0,
        _nutrientName[10]: 0.0,
        _nutrientName[11]: 0.0,
        _nutrientName[12]: 0.0,
        _nutrientName[13]: 0.0,
        _nutrientName[14]: 0.0,
      };
    }
  }

  /* グラフ用栄養素の作成 */
  /* タンパク質 */
  double get _graphMenuProtein {
    if (_isMenu) {
      double protein = menu.menuProtein / _myChildDRI['protein'] * 100;
      if (protein < 100) return protein;
      return 100.0;
    } else {
      return 0.0;
    }
  }

  /* ビタミン */
  double get _graphMenuVitamin {
    if (_isMenu) {
      double retinol = menu.menuRetinol / _myChildDRI['retinol'] * 100;
      double vitaminB1 = menu.menuVitaminB1 / _myChildDRI['vitaminB1'] * 100;
      double vitaminB2 = menu.menuVitaminB2 / _myChildDRI['vitaminB2'] * 100;
      double vitaminC = menu.menuVitaminC / _myChildDRI['vitaminC'] * 100;
      double vitamin = (retinol + vitaminB1 + vitaminB2 + vitaminC) / 4;
      if (vitamin < 100) return vitamin;
      return 100.0;
    } else {
      return 0.0;
    }
  }

  /* ミネラル */
  double get _graphMenuMineral {
    if (_isMenu) {
      double calcium = menu.menuCalcium / _myChildDRI['calcium'] * 100;
      double iron = menu.menuIron / _myChildDRI['iron'] * 100;
      double magnesium = menu.menuMagnesium / _myChildDRI['magnesium'] * 100;
      double zinc = menu.menuZinc / _myChildDRI['zinc'] * 100;
      double mineral = (calcium + iron + magnesium + zinc) / 4;
      if (mineral < 100) return mineral;
      return 100.0;
    } else {
      return 0.0;
    }
  }

  /* 炭水化物 */
  double get _graphMenuCarbohydrate {
    if (_isMenu) {
      double carbohydrate =
          menu.menuCarbohydrate / _myChildDRI['carbohydrate'] * 100;
      double dietaryFiber =
          menu.menuDietaryFiber / _myChildDRI['dietaryFiber'] * 100;
      double totalCarb = (carbohydrate + dietaryFiber) / 2;
      if (totalCarb < 100) return totalCarb;
      return 100.0;
    } else {
      return 0.0;
    }
  }

  /* 脂質 */
  double get _graphMenuLipid {
    if (_isMenu) {
      double lipid = menu.menuLipid / _myChildDRI['lipid'] * 100;
      if (lipid < 100) return lipid;
      return 100.0;
    } else {
      return 0.0;
    }
  }

  /* 詳細画面に遷移 */
  void handleToDetail(int selectIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/detail'),
        builder: (BuildContext context) => Detail(
          dri: dri,
          dailyMenu: menu,
          child: child,
          menuNum: selectIndex,
          // 選んだ数字を遷移させることで料理毎の処理を可能
        ),
      ),
    );
  }

  /* タイトルバー表示 */
  Widget _titleBar(String title) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      width: double.infinity, // 画面いっぱいに出すよ
      color: Colors.orangeAccent,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          color: Colors.black54,
        ),
      ),
    );
  }

  /* メニュー名表示 */
  Widget _menuNameList() {
    if (_isMenu) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: List.generate(menu.menu.length, (int selectIndex) {
                return InputChip(
                  label: Text(menu.menu[selectIndex].name), // 今日のメニューを表示する
                  onPressed: () {
                    handleToDetail(selectIndex); // (i)番目の料理名のChipクリックで詳細画面に遷移
                  },
                );
              }),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black45,
              ),
              children: [
                TextSpan(text: '本日の給食は'),
                TextSpan(
                  text: 'お休み',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).primaryColor,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
                TextSpan(text: 'です.'),
              ],
            ),
          ),
        ),
      );
    }
  }

  /* 栄養素リスト */
  Widget _nutrientList() {
    return Column(
      children: List.generate(_nutrientName.length, (int i) {
        // 栄養素の名前、数値、線を一つにまとめてリストにしている
        if (i.isOdd) {
          return _nutrientLabel(
            name: _nutrientName[i],
            value: _nutrientValue[_nutrientName[i]],
            unit: _units[_nutrientName[i]],
          );
        } else {
          return _nutrientLabel(
            name: _nutrientName[i],
            value: _nutrientValue[_nutrientName[i]],
            unit: _units[_nutrientName[i]],
            color: Color(0xFFffead6),
          );
        }
      }),
    );
  }

  /* 栄養素ラベル */
  Widget _nutrientLabel(
      {@required String name,
        @required double value,
        @required String unit,
        Color color}) {
    return Container(
      height: 35.0,
      color: color,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  value.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '　' + unit,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* 栄養素をグラフ表示 */
  Widget _graph(double deviceWidth, double deviceHeight) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0),
        width: deviceWidth, // コンテイナーの横幅を変数指定
        height: deviceHeight, // コンテイナーの縦幅を変数指定
        child: RadarChart(
          // レーダーチャート
          labelWidth: 200,
          values: [
            _graphMenuProtein,
            _graphMenuLipid,
            _graphMenuCarbohydrate,
            _graphMenuVitamin,
            _graphMenuMineral,
          ],
          labels: [
            'タンパク質\n(' + _graphMenuProtein.toStringAsFixed(0) + '％)',
            '脂質\n(' + _graphMenuLipid.toStringAsFixed(0) + '％)',
            '炭水化物\n(' + _graphMenuCarbohydrate.toStringAsFixed(0) + '％)',
            'ビタミン\n(' + _graphMenuVitamin.toStringAsFixed(0) + '％)',
            'ミネラル\n(' + _graphMenuMineral.toStringAsFixed(0) + '％)',
          ],
          maxValue: 100, // グラフの最大値は100
          fillColor: Colors.orange, // グラフの色はオレンジで塗ります
          animate: false, // アニメーションはつけない
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size; // デバイス毎のサイズを持ってくる(縦幅と横幅両方)
    return ListView(
      // リストで並べる
      physics: AlwaysScrollableScrollPhysics(), // コンテンツが不十分な場合でも常にスクロール可能
      controller: _controller, // スクロール可能なウィジェットになる
      children: <Widget>[
        _titleBar('料理名'),
        _menuNameList(), // メニューの名前表示
        _titleBar('栄養素'),
        _graph(_size.width * 0.65, _size.height * 0.65), // グラフの縦幅と横幅は65%
        _nutrientList(),
      ],
    );
  }
}