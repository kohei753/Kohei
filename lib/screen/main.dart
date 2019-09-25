import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

/* 各画面をインポート */
import 'package:sample/screen/splash.dart';
import 'package:sample/screen/entry.dart';
import 'package:sample/screen/home.dart';
import 'package:sample/screen/detail.dart';
import 'package:sample/screen/monthlyMenu.dart';
import 'package:sample/screen/setting.dart';
import 'package:sample/screen/information.dart';

void main() {
  runApp(
    MaterialApp(
      title: '給食アプリ(仮)',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        // primaryColor: Color(0xFFe1a067), // 一応チームカラー(汚かった)
      ),
      /* 画面遷移スタックを名前で管理する */
      home: Splash(), // スプラッシュ
      // home: Detail(), // デバッグ用
      routes: <String, WidgetBuilder>{
        '/entry': (BuildContext context) => Entry(), // 初回起動時にのみ表示される画面
        '/home': (BuildContext context) => Home(), // 1日の献立を表示する画面
        '/detail': (BuildContext context) => Detail(), // 各料理の詳細画面を表示する画面
        '/monthly-menu': (BuildContext context) => MonthlyMenu(), // 献立表を表示する画面
        '/setting': (BuildContext context) => Setting(), // 設定画面
        '/information': (BuildContext context) => Information(), // データ元などのインフォ画面
      },
    ),
  );
}
