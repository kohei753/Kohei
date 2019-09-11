import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: '給食アプリ(仮)',
    theme: ThemeData(
      primaryColor: Colors.deepOrangeAccent,
    ),
    /* 画面遷移スタックを名前で管理する */
    home: Splash(), // スプラッシュ
    routes: <String, WidgetBuilder>{
      '/entry': (BuildContext context) => Entry(), // 初回起動時にのみ表示される画面
      '/home': (BuildContext context) => Home(), // 1日の献立を表示する画面
      '/detail': (BuildContext context) => Detail(), // 各料理の詳細画面を表示する画面
      '/monthly-menu': (BuildContext context) => MonthlyMenu(), // 献立表を表示する画面
      '/setting': (BuildContext context) => Setting(), // 設定画面
      '/information': (BuildContext context) => Information(), // データ元などのインフォ画面
    },
  ));
}

/* スプラッシュ画面 */
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  /* スプラッシュ中の処理
   * ネイティブでやった方が綺麗だし、本来の意味のスプラッシュとして
   * 利用できると思うが、ここで多分初期情報とかを読み込むと思うから
   * それをネイティブからやるの難しそうだったのでとりあえすここに書いてる */
  @override
  void initState() {
    // 最初に読み込まれる
    super.initState();

    Future.delayed(const Duration(seconds: 2))
        .then((value) => handleTimeout()); // ディレイは適当に2秒
  }

  /* スプラッシュで表示するアイコンだとかの処理はここ */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  /* タイムアウトした後の処理
   * 今回はとりあえずホーム画面に移動させてる */
  void handleTimeout() {
    // ホーム画面へ
    Navigator.pushReplacementNamed(context, '/home');
  }
}

/* 初期登録画面 */
class Entry extends StatefulWidget {
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

/* ホーム画面 */
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* BottomNavigationBarで使用する諸々 */
  int _selectedIndex = 0; // 選択中のタブ番号を管理
  static const List<Widget> _widgetOptions = <Widget>[
    /* TODO:ここに今日の献立の画面と献立表の画面のウィジェットをうまく管理する */
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: 献立表',
    ),
  ];

  void _onItemTapped(int index) {
    // メニューがタップされた時更新
    setState(() {
      _selectedIndex = index;
    });
  }

  /* 1日の献立画面のウィジェット */
  Widget _buildHome() {
    return null;
  }

  void _handleSetting() {
    // 設定画面へ
    Navigator.pushNamed(context, '/setting');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('日付'), // TODO:表示したい日付に変わる予定
        actions: <Widget>[
          // 設定ボタン
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _handleSetting, // 設定画面に遷移
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // ListになってるWidgetを読み込む
      bottomNavigationBar: BottomNavigationBar(
        // タブバーの実装
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // 1日の献立を表示する画面に遷移するアイコン
            icon: Icon(
              Icons.view_list,
              size: 30,
            ),
            title: Text('献立'),
          ),
          BottomNavigationBarItem(
            // 献立表を表示する画面に遷移するアイコン
            icon: Icon(
              Icons.calendar_today,
              size: 30,
            ),
            title: Text('献立表'),
          ),
        ],
        currentIndex: _selectedIndex, // 選択中の画面を管理
        selectedItemColor: Colors.deepOrangeAccent, // 選択時の色
        onTap: _onItemTapped, // タップすると更新
      ),
    );
  }
}

/* 詳細画面 */
class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

/* 献立表画面 */
class MonthlyMenu extends StatefulWidget {
  @override
  _MonthlyMenuState createState() => _MonthlyMenuState();
}

class _MonthlyMenuState extends State<MonthlyMenu> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

/* 設定画面 */
class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

/* インフォメーション画面 */
class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
