import 'package:flutter/material.dart';

/* アプリ内で使う文字列のストレージ */
class MenuStrings {
  static const List<String> nutrientName = [
    'エネルギー',
    'タンパク質',
    '脂質',
    '炭水化物',
    'ナトリウム',
    'カルシウム',
    'マグネシウム',
    '鉄分',
    '亜鉛',
    'レチノール',
    'ビタミンB1',
    'ビタミンB2',
    'ビタミンC',
    '食物繊維',
    '食塩相当量',
  ];
  static const Map<String, String> units = {
    'エネルギー': 'kcal',
    'タンパク質': 'g',
    '脂質': 'g',
    '炭水化物': 'g',
    'ナトリウム': 'mg',
    'カルシウム': 'mg',
    'マグネシウム': 'mg',
    '鉄分': 'mg',
    '亜鉛': 'mg',
    'レチノール': 'µg',
    'ビタミンB1': 'mg',
    'ビタミンB2': 'mg',
    'ビタミンC': 'mg',
    '食物繊維': 'g',
    '食塩相当量': 'g',
  };
  static const List<String> menuIcon = [
    'assets/staple.png',
    'assets/drink.png',
    'assets/side_green.png',
    'assets/side_red.png',
    'assets/side_orenge.png',
    'assets/side_purple.png',
  ];
  static const List<Color> mainDetailColors = [
//    Color(0xFFf6f183),
    Color(0xFFffff33),  // 濃い黄色
    Color(0xFF82c1f5),
    Color(0xFF87f582),
    Color(0xFFf58287),
    Color(0xFFffba66),
    Color(0xFFb682f5),
  ];
  static const List<Color> listDetailColors = [
//    Color(0xFFffffd6),
    Color(0xFFffffb2),  // 濃い黄色
    Color(0xFFd6eaff),
    Color(0xFFd6ffd6),
    Color(0xFFffd6d6),
    Color(0xFFffead6),
    Color(0xFFead6ff),
  ];
}

class InfoStrings {
  static const String dataTitle = '利用データについて';
  static const String dataLocation =
      '　本サービスは, 函館市が公開しているオープンデータと, 協力をいただいた函館市の小中学校から提供されたデータもとに作成しています.';
  static const String dataAttention =
      '　また, 本サービスで扱っている給食の献立や材料は予定であり, 予告なく変更されることがあります. これらの理由から本サービス上のデータは正確性が保証されておらず, サービス内の情報によるトラブル・事故等において, 本サービスの製作者及び関係団体は一切責任を負いません. 正確な情報は, 函館市役所及び各学校の担当職員へ問い合わせください.';
  static const String openData = 'オープンデータ';
  static const String linkInternalAffairsCommunications = '総務省 地方公共団体のオープンデータの推進';
  static const String usingData = '利用中のデータ(敬称略)';
  static const String noOpenData = '現在オープンデータを使用しておりません.';
  static const String nutrientBase = '厚生労働省 日本人の食事摂取基準';
  static const String schoolLunchBase = '文部科学省 学校給食実施基準';
  static const String illustration1 = 'イラストレイン';
  static const String illustration2 = 'ICOOON MONO';
  static const String cooperationSchools = '協力していただいている学校(敬称略)';
  static const List<String> cooperationSchoolsValue = [
    '巴中学校',
  ];

  static const String personalTitle = '個人情報の扱い';
  static const String personalText = '　本サービスは個人のプライバシー, 名誉, その他第三者の権利を侵害することのないよう, 利用者に関する情報の取扱に充分, 配慮します. また, 本サービス内で登録されたユーザの名前, 性別, 学校, 学年はサービスの向上以外の目的では使用されず, 収集も行いません.';

  static const String contactTitle = 'お問い合わせ';
  static const String developerTitle = '開発者';
  static const String developer = '公立はこだて未来大学 使ってもらって学ぶフィールド思考システムデザイン2019 市民情報サービスのデザインチーム';
}

class HelpStrings {
  static const String graphTitle = '栄養素の分類';
  static const String graphText = 'グラフなどで利用されている栄養素は, 文部科学省が定めている「児童又は生徒一人当たりの学校給食摂取基準」に基づいて表示しています.';
  static const String graphBase = '12 ~ 14歳の中学生の場合, 以下の栄養素が基準となっています.';
  static const String nutrientLink = '児童又は生徒一人当たりの学校給食摂取基準';
  static const String graphOther = '上記の他に摂取量について配慮するものは以下のようになっています.';
}

class DevelopingStrings {
  static const String noDevelop = '本機能は現在製作中です.';
}