import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

/* 各画面をインポート */
import 'package:sample/screen/splash.dart';

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
    ),
  );
}
