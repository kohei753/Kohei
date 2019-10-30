import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:flutter/services.dart'; // 画面縦に固定するやつ

/* 各画面をインポート */
import 'package:sample/screen/splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // 画面を縦に固定
  runApp(
    MaterialApp(
      title: 'はこんだて',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        // primaryColor: Color(0xFFe1a067),Color(0xFF66cdaa), // 一応チームカラー(汚かった)と太郎さんのやつ
      ),
      // home: Splash(), // スプラッシュ
      home: Splash(),
    ),
  );
}
