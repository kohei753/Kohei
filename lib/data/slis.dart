/* 学校給食実施基準を扱うクラス
* SLIS = School lunch implementation standards */
import 'dart:async'; // 非同期処理
import 'dart:convert'; // JSON関係のコンバート

import 'package:json_annotation/json_annotation.dart'; // JSONのシリアライズ
import 'package:flutter/services.dart' show rootBundle; // ローカルファイルへのアクセス

import 'child.dart';

part 'slis.g.dart';

@JsonSerializable(createToJson: false)
class SLIS {
  /* 全栄養基準 */
  final NutrientSLIS energy;
  final NutrientSLIS protein;
  final NutrientSLIS lipid;
  final NutrientSLIS carbohydrate;
  final NutrientSLIS sodium;
  final NutrientSLIS calcium;
  final NutrientSLIS magnesium;
  final NutrientSLIS iron;
  final NutrientSLIS zinc;
  final NutrientSLIS retinol;
  final NutrientSLIS vitaminB1;
  final NutrientSLIS vitaminB2;
  final NutrientSLIS vitaminC;
  final NutrientSLIS dietaryFiber;
  final NutrientSLIS salt;

  SLIS(
      this.energy,
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

  factory SLIS.fromJson(Map<String, dynamic> json) => _$SLISFromJson(json);

  /* child型を読み取って適切なデータを返す */
  Map<String, double> getSLIS(Child child) {
    Map<String, double> fittedData = {};
    if (child.schoolYear < 1 || 10 < child.schoolYear) return fittedData;
    int grade;
    if (child.schoolYear < 3) {
      grade = 0;
    } else if (child.schoolYear < 5) {
      grade = 1;
    } else if (child.schoolYear < 7) {
      grade = 2;
    } else {
      grade = 3;
    }

    fittedData['energy'] = this.energy.years[grade];
    fittedData['protein'] = this.protein.years[grade];
    fittedData['lipid'] = this.lipid.years[grade];
    fittedData['carbihydrate'] = this.carbohydrate.years[grade];
    fittedData['sodium'] = this.sodium.years[grade];
    fittedData['calcium'] = this.calcium.years[grade];
    fittedData['magnecium'] = this.magnesium.years[grade];
    fittedData['iron'] = this.iron.years[grade];
    fittedData['zinc'] = this.zinc.years[grade];
    fittedData['retinol'] = this.retinol.years[grade];
    fittedData['vitaminB1'] = this.vitaminB1.years[grade];
    fittedData['vitaminB2'] = this.vitaminB2.years[grade];
    fittedData['vitaminC'] = this.vitaminC.years[grade];
    fittedData['dietaryFiber'] = this.dietaryFiber.years[grade];
    fittedData['salt'] = this.salt.years[grade];

    return fittedData;
  }
}

/* １つの栄養素のSLIS */
@JsonSerializable(createToJson: false)
class NutrientSLIS {
  /* 各学年の実数値 */
  final double low;
  final double middle;
  final double high;
  final double junior;

  List<double> years;

  NutrientSLIS(this.low, this.middle, this.high, this.junior) {
    years = [
      this.low,
      this.middle,
      this.high,
      this.junior,
    ];
  }

  factory NutrientSLIS.fromJson(Map<String, dynamic> json) =>
      _$NutrientSLISFromJson(json);
}

/* JSONを読み取り、マップにして返す */
Future<SLIS> getSLIS() async {
  var _slis; // 返り値となる変数
  final _jsonDRI = await rootBundle.loadString('assets/SLIS.json'); // ファイル読み込み
  final _decodeDRI = json.decode(_jsonDRI); // String => json
  _slis = SLIS.fromJson(_decodeDRI); // json => Menu

  return _slis;
}