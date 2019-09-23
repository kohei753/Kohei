import 'dart:async'; // 非同期処理関係
import 'dart:convert'; // JSON関係のコンバート
import 'dart:io'; // ファイル関係

import 'package:json_annotation/json_annotation.dart'; // JSONのシリアライズ
import 'package:path_provider/path_provider.dart'; // ローカルパスにアクセス

part 'child.g.dart';

/* 個人情報を扱うクラス */
@JsonSerializable()
class Child {
  /* 変数宣言 */
  final String name; // 名前
  final String school; // 通ってる学校
  final int schoolYear; // 学年
  final String sex; // 性別

  /* コンストラクター */
  Child(this.name, this.school, this.schoolYear, this.sex);

  /* シリアライズ */
  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);
  Map<String, dynamic> toJson() => _$ChildToJson(this);
}

/* 個人情報を保持しているストレージを扱う関数 */
/* 初期起動を認識 */
// STEP.1 ローカルファイルのPATHを取得
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

// STEP.2 ファイルオブジェクトを取得
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/child.json'); // childに個人の情報を保持
}

// STEP.3 ファイルの読み込み(すでに内容があった場合は初起動じゃない)
Future<Child> readInfo() async {
  try {
    var child; // 個人情報をクラスで扱いたい
    final file = await _localFile;

    // Read the file.
    final String contents = await file.readAsString();

    // TODO: 読み込んだデータをChild型にパースする
    final _decodeChild = json.decode(contents);
    child = Child.fromJson(_decodeChild);

    return child;
  } catch (e) {
    // TODO: 失敗した時(初起動時)は空のChildクラスを返す
    return Child(null, null, null, null);
  }
}

// STEP.4 ファイルの書き込み
Future<File> writeInfo(Child newInfo) async {
  final file = await _localFile;

  // Write the file.
  // TODO: child型を受け取ってうまい具合に記録する
  final encodedInfo = json.encode(newInfo.toJson());
  return file.writeAsString(encodedInfo.toString());
}
