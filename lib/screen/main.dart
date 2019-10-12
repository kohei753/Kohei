import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:sample/screen/entry.dart';

/* 各画面をインポート */
import 'package:sample/screen/splash.dart';

void main() {
  runApp(
    MaterialApp(
      title: '給食アプリ(仮)',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        // primaryColor: Color(0xFFe1a067),Color(0xFF66cdaa), // 一応チームカラー(汚かった)と太郎さんのやつ
      ),
      home: Splash(), // スプラッシュ
    ),
  );
}
