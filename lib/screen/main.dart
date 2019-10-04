import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

/* 各画面をインポート */
import 'package:sample/screen/splash.dart';

void main() {
  runApp(
    MaterialApp(
      title: '給食アプリ(仮)',  // HELP  Good name
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        // primaryColor: Color(0xFFe1a067), // 一応チームカラー(汚かった)
      ),
      home: Splash(), // スプラッシュ
    ),
  );
}
