import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'menu.dart' as menus;
import 'child.dart' as child;

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
  var allMenu = {};  // jsonのメニューを格納する変数
  var myChild;

  @override
  void initState() {
    // 最初に読み込まれる
    super.initState();

    // 献立データを取得 => value
    menus.getMenus().then((value) {
      allMenu = value;
      print("読み込めてるかーな"); // ok!
      // TODO: 各画面に読み込んだデータを受け渡しつつ遷移
    });

    // 登録データを取得
    child.readInfo().then((value) {
      myChild = value;
      if (myChild.name == null) {
        handleToEntry();
      } else {
        handleToHome();
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
    Navigator.pushReplacementNamed(context, '/entry');
  }

  /* ホームへの遷移 */
  void handleToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }
}