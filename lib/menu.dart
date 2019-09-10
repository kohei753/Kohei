/* 一日の献立に関するクラス */

import 'dish.dart';

class Menu {
  /* 変数宣言 */
  final DateTime day; // 日付
  final String school;  // 学校

  final List<Dish> menu;  // メニューリスト

  /* コンストラクター */
  Menu(this.day,
       this.school,
       this.menu);

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