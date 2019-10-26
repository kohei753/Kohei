import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:intl/intl.dart';  // DateTimeのフォーマットに使う
import 'package:multi_charts/multi_charts.dart';

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'package:sample/data/strings.dart';

/* 詳細画面 */
class Detail extends StatefulWidget {
  final Menu dailyMenu;
  final DRI dri;
  final int menuNum;  // 選択されたメニューの番号
  Detail({Key key, this.dailyMenu, this.dri, this.menuNum}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  /* 諸々データ */
  Menu dailyMenu; // 表示する日のメニューデータ
  DRI dri;
  
  /* この画面でのみ使用する変数 */
  int _selectedIndex = 0; // 選択中のタブ番号管理
  DateFormat formatter = DateFormat("yyyy/MM/dd(E)"); // 日付をフォーマットするやつ
  ScrollController _controller = ScrollController();  // スクロール制御

  /* それぞれの栄養素の名前と値・単位 */
  final List<String> _nutrientName = MenuStrings.nutrientName;
  Map<String, double> _nutrientValue;
  final Map<String, String> _units = MenuStrings.units;
  
  /* カラーリスト */
  List<Color> _mainDetailColors = MenuStrings.mainDetailColors;
  List<Color> _listDetailColors = MenuStrings.listDetailColors;

  /* サイドバーの各メニューのアイコン
  *  色が上のカラーリストと対応している */
  List<String> _menuIcon = MenuStrings.menuIcon;

  /* 読み込まれた時にデータを取得する */
  @override
  void initState() {
    super.initState();
    dailyMenu = widget.dailyMenu;
    dri = widget.dri;

    if (widget.menuNum != null) _selectedIndex = widget.menuNum;

    _updateNutrientValue();
  }

  void _updateNutrientValue() {
    _nutrientValue = {
      _nutrientName[0]: dailyMenu.menu[_selectedIndex].dishEnergy,
      _nutrientName[1]: dailyMenu.menu[_selectedIndex].dishProtein,
      _nutrientName[2]: dailyMenu.menu[_selectedIndex].dishLipid,
      _nutrientName[3]: dailyMenu.menu[_selectedIndex].dishCarbohydrate,
      _nutrientName[4]: dailyMenu.menu[_selectedIndex].dishSodium,
      _nutrientName[5]: dailyMenu.menu[_selectedIndex].dishCalcium,
      _nutrientName[6]: dailyMenu.menu[_selectedIndex].dishMagnesium,
      _nutrientName[7]: dailyMenu.menu[_selectedIndex].dishIron,
      _nutrientName[8]: dailyMenu.menu[_selectedIndex].dishZinc,
      _nutrientName[9]: dailyMenu.menu[_selectedIndex].dishRetinol,
      _nutrientName[10]: dailyMenu.menu[_selectedIndex].dishVitaminB1,
      _nutrientName[11]: dailyMenu.menu[_selectedIndex].dishVitaminB2,
      _nutrientName[12]: dailyMenu.menu[_selectedIndex].dishVitaminC,
      _nutrientName[13]: dailyMenu.menu[_selectedIndex].dishDietaryFiber,
      _nutrientName[14]: dailyMenu.menu[_selectedIndex].dishSalt,
    };
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _updateNutrientValue();
    });
  }

  /* タイトルバー表示 */
  Widget _titleBar(String title) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      width: double.infinity, // 画面いっぱいに出すよ
      color: _mainDetailColors[_selectedIndex],
      child: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          color: Colors.black54,
        ),
      ),
    );
  }

  /*材料名表示*/
  Widget _materialList() {
    return Column(
      children: List.generate(dailyMenu.menu[_selectedIndex].dish.length, (int i) {
        // 栄養素の名前、数値、線を一つにまとめてリストにしている
        if (i.isOdd) {
          return _materialLabel(
            name: dailyMenu.menu[_selectedIndex].dish[i].name,
          );
        } else {
          return _materialLabel(
            name: dailyMenu.menu[_selectedIndex].dish[i].name,
            color: _listDetailColors[_selectedIndex],
          );
        }
      }),
    );
  }

  /* 材料名ラベル */
  Widget _materialLabel({@required String name, Color color}) {
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
            flex: 9,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
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
            color: _listDetailColors[_selectedIndex],
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

  /* サイドメニューを生成 */
  Widget _buildDrawer() {
    return Drawer(
      child: ListView.builder(
        // 中身はリスト表示
        padding: EdgeInsets.zero, // 余白を消去
        itemCount: dailyMenu.menu.length + 1, // +1はヘッダーを作成するため
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
            title: Text(dailyMenu.menu[index].name), // とりあえず名前だしてるだけ
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
        dailyMenu.menu[_selectedIndex].name,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 20, // ちょっと大きめに
        ),
      ),
      accountEmail: Text(
        // 日付
        formatter.format(dailyMenu.day),
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
        color: _mainDetailColors[_selectedIndex], // 背景色も変えられるよ
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dailyMenu.menu[_selectedIndex].name,
          style: TextStyle(color: Colors.black54),
        ), // 選択した料理名に
        backgroundColor: _mainDetailColors[_selectedIndex],
      ),
      endDrawer: _buildDrawer(), // サイドメニュー
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(), //コンテンツが不十分な場合でも常にスクロール可能
        controller: _controller, //スクロールできるようになる
        children: <Widget>[
          _titleBar("材料"),
          _materialList(),
          _titleBar("栄養素"),
          _nutrientList(),
        ],
      )
    );
  }
}
