import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart' as menu;
import 'package:sample/data/child.dart' as child;
import 'package:sample/data/dri.dart' as dri;
import 'firstEntry.dart';
import 'home.dart';

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
  Map<DateTime, menu.Menu> menus = {}; // jsonのメニューを格納する変数
  child.Child myChild; // 登録情報
  dri.DRI DRI;  // 食事摂取基準

  // 取得するべき情報を取得できたかを管理する連想配列
  Map<String, bool> acquired = {
    'menu': false,
    'info': false,
    'DRI': false,
  };

  @override
  void initState() {
    // 最初に読み込まれる
    super.initState();

    // 献立データを取得
    menu.getMenus().then((value) {
      menus = value;
      acquired['menu'] = true;

      handleToNext();
    });

    // 登録データを取得
    child.readInfo().then((value) {
      myChild = value;
      acquired['info'] = true;

      handleToNext();
    });

    // 食事摂取基準データを取得
    dri.getDRI().then((value) {
      DRI = value;
      acquired['DRI'] = true;

      handleToNext();
    });
  }

  /* 全てのデータを取得している場合は次の画面へ遷移する */
  void handleToNext() {
    if (isAllFinish()) {
      if (myChild.name == null) { handleToEntry(); }
        else { handleToHome(); }
    }
  }

  /* 全ての非同期処理が終了したかを判断 */
  bool isAllFinish() {
    bool allFinished = true;
    acquired.forEach((String key, bool value) {
      if (!value) allFinished = false;
    });

    return allFinished;
  }

  /* 初期登録への遷移 */
  void handleToEntry() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/entry'),
          builder: (BuildContext context) => FirstEntry(menus: menus, dri: DRI),
        ));
  }

  /* ホームへの遷移 */
  void handleToHome() {
    DateTime today = DateTime.now();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/home'),
          builder: (BuildContext context) => Home(menus: menus, child: myChild, dri: DRI, selectDay: DateTime(today.year, today.month, today.day)),
        ));
  }

  /* スプラッシュで表示するアイコンだとかの処理はここ */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlutterLogo();
  }
}
