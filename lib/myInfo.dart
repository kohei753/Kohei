import 'dart:async';  // 非同期処理関係
import 'dart:io'; // ファイル関係

import 'package:path_provider/path_provider.dart';  // ローカルパスにアクセス

/* 個人情報を扱うクラス */
class MyInfo {
  /* 変数宣言 */
  final String name;
  final String school;
  final String sex;

  /* コンストラクター */
  MyInfo(this.name, this.school, this.sex);
}

/* 個人情報を保持しているストレージを扱うクラス */
class MyInfoStorage {
  /* 初期起動を認識 */
  // STEP.1 ローカルファイルのPATHを取得
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // STEP.2 ファイルオブジェクトを取得
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/myInfo.txt');  // myInfoに個人の情報を保持
  }

  // STEP.3 ファイルの読み込み(すでに内容があった場合は初起動じゃない)
  Future<MyInfo> readInfo() async {
    try {
      var myInfo; // 個人情報をクラスで扱いたい
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      // TODO: 読み込んだデータをMyInfo型にパースする

      return myInfo;
    } catch (e) {
      // TODO: 失敗した時(初起動時)は空のMyInfoクラスを返す
      return null;
    }
  }

  // STEP.4 ファイルの書き込み
  Future<File> writeInfo(MyInfo newInfo) async {
    final file = await _localFile;

    // Write the file.
    // TODO: myInfo型を受け取ってうまい具合に記録する
    return file.writeAsString('newInfo');
  }
}