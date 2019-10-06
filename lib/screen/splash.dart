import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart' as menu;
import 'package:sample/data/child.dart' as child;
import 'entry.dart';
import 'home.dart';
import 'detail.dart';

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

  bool isGetMenu = false; // メニューリストを取得できたか
  bool isGetInfo = false; // 登録情報を取得できたか

  @override
  void initState() {
    // 最初に読み込まれる
    super.initState();

    // 献立データを取得
    menu.getMenus().then((value) {
      menus = value;
      // TODO: 各画面に読み込んだデータを受け渡しつつ遷移
      isGetMenu = true;

      if (isGetInfo) {
        if (myChild.name == null) {
          handleToEntry();
        } else {
          handleToHome();
        }
      }
    });

    // 登録データを取得
    child.readInfo().then((value) {
      myChild = value;
      isGetInfo = true;

      if (isGetMenu) {
        if (myChild.name == null) {
          handleToEntry();
        } else {
          handleToHome();
        }
      }
    });
  }

  /* スプラッシュで表示するアイコンだとかの処理はここ */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlutterLogo();
  }

  /* 初期登録への遷移 */
  void handleToEntry() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/entry'),
          builder: (BuildContext context) => Entry(),
        ));
  }

  /* ホームへの遷移 */
  void handleToHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/home'),
          builder: (BuildContext context) => Home(menus: menus, child: myChild),
        ));
  }
}
