/* 一日の献立に関するクラス */
import 'dart:async';  // 非同期処理
import 'dart:convert';  // JSON関係のコンバート

import 'package:json_annotation/json_annotation.dart';  // JSONのシリアライズ
import 'package:flutter/services.dart' show rootBundle; // ローカルファイルへのアクセス
import 'package:intl/intl.dart';  // DateTimeのパース処理

import 'dish.dart';

part 'menu.g.dart';

@JsonSerializable(createToJson: false)
class Menu {
  /* 変数宣言 */
  @JsonKey(name: 'day', fromJson: _parseDay)
  final DateTime day; // 日付
  final String school;  // 学校

  final List<Dish> menu;  // メニューリスト

  /* コンストラクター */
  Menu(this.day,
       this.school,
       this.menu);

  /* JSONからの読み取り */
  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  /* dayをパースして格納する関数 */
  static DateTime _parseDay(dynamic value) => DateFormat('yyyy-MM-dd').parse(value);

  /* 各パラメータgetter */

  /* 各栄養素の総合値を調べる */
  double get menuEnergy {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishEnergy;
    }
    return result;
  }

  double get menuProtein {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishProtein;
    }
    return result;
  }

  double get menuLipid {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishLipid;
    }
    return result;
  }

  double get menuCarbohydrate {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishCarbohydrate;
    }
    return result;
  }

  double get menuSodium {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishSodium;
    }
    return result;
  }

  double get menuCalcium {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishCalcium;
    }
    return result;
  }

  double get menuMagnesium {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishMagnesium;
    }
    return result;
  }

  double get menuIron {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishIron;
    }
    return result;
  }

  double get menuZinc {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishZinc;
    }
    return result;
  }

  double get menuRetinol {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishRetinol;
    }
    return result;
  }

  double get menuVitaminB1 {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishVitaminB1;
    }
    return result;
  }

  double get menuVitaminB2 {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishVitaminB2;
    }
    return result;
  }

  double get menuVitaminC {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishVitaminC;
    }
    return result;
  }

  double get menuDietaryFiber {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishDietaryFiber;
    }
    return result;
  }

  double get menuSalt {
    var result = 0.0;
    for (var i = 0; i < menu.length; i++) {
      result += menu[i].dishSalt;
    }
    return result;
  }
}

/* 全メニューを読みとるクラス */
@JsonSerializable(createToJson: false)
class Menus {
  /* 変数宣言 */
  final List<Menu> menus;

  /* コンストラクター */
  Menus(this.menus);

  /* JSONからの読み取り */
  factory Menus.fromJson(Map<String, dynamic> json) => _$MenusFromJson(json);
}

/* JSONを読み取り、マップにして返す */
Future<Map<DateTime, Menu>> getMenus() async {
  final Map<DateTime, Menu> _menus = {};
  final _jsonMenus = await rootBundle.loadString('assets/august.json');
  final _decodeMenus = json.decode(_jsonMenus);
  for(var i = 0; i < _decodeMenus.length; i++) {
    var menu = Menu.fromJson(_decodeMenus[i]);
    _menus[menu.day] = menu;
  }
  return _menus;
}