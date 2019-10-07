/* 食事摂取基準を扱うクラス */
import 'dart:async'; // 非同期処理
import 'dart:convert'; // JSON関係のコンバート

import 'package:json_annotation/json_annotation.dart'; // JSONのシリアライズ
import 'package:flutter/services.dart' show rootBundle; // ローカルファイルへのアクセス

part 'package:sample/data/dri.g.dart';

/* 栄養素別の食事摂取基準 */
@JsonSerializable(createToJson: false)
class DRI {
  /* FoodStuffと同じ名前 */
  final YearStandard protein;
  final YearStandard lipid;
  final YearStandard carbohydrate;
  final YearStandard sodium;
  final YearStandard calcium;
  final YearStandard magnesium;
  final YearStandard iron;
  final YearStandard zinc;
  final YearStandard retinol;
  final YearStandard vitaminB1;
  final YearStandard vitaminB2;
  final YearStandard vitaminC;
  final YearStandard dietaryFiber;
  final YearStandard salt;

  DRI(
      this.protein,
      this.lipid,
      this.carbohydrate,
      this.sodium,
      this.calcium,
      this.magnesium,
      this.iron,
      this.zinc,
      this.retinol,
      this.vitaminB1,
      this.vitaminB2,
      this.vitaminC,
      this.dietaryFiber,
      this.salt);

  /* JSONからの読み取り */
  factory DRI.fromJson(Map<String, dynamic> json) => _$DRIFromJson(json);
}

/* 各学年別の食事摂取基準 */
@JsonSerializable(createToJson: false)
class YearStandard {
  /* 各学年(primary: 小学校, junior: 中学校) */
  final GenderStandard primary1;
  final GenderStandard primary2;
  final GenderStandard primary3;
  final GenderStandard primary4;
  final GenderStandard primary5;
  final GenderStandard primary6;
  final GenderStandard junior1;
  final GenderStandard junior2;
  final GenderStandard junior3;

  YearStandard(this.primary1, this.primary2, this.primary3, this.primary4,
      this.primary5, this.primary6, this.junior1, this.junior2, this.junior3);

  /* JSONからの読み取り */
  factory YearStandard.fromJson(Map<String, dynamic> json) =>
      _$YearStandardFromJson(json);
}

/* 男女別の食事摂取基準 */
@JsonSerializable(createToJson: false)
class GenderStandard {
  final double man; // 男の食事摂取基準
  final double woman; // 女の食事摂取基準

  GenderStandard(this.man, this.woman);

  /* JSONからの読み取り */
  factory GenderStandard.fromJson(Map<String, dynamic> json) =>
      _$GenderStandardFromJson(json);
}

/* JSONを読み取り、マップにして返す */
Future<DRI> getDRI() async {
  var _dri;  // 返り値となる変数
  final _jsonDRI = await rootBundle.loadString('assets/DRI.json'); // ファイル読み込み
  final _decodeDRI = json.decode(_jsonDRI); // String => json
  _dri = DRI.fromJson(_decodeDRI);  // json => Menu
  
  return _dri;
}