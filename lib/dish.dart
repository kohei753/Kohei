/* 1つのメニューに関するクラス */
import 'package:json_annotation/json_annotation.dart';

import 'foodStuff.dart';

part 'dish.g.dart';

@JsonSerializable(createToJson: false)
class Dish {
  /* 変数宣言 */
  final List<FoodStuff> dish; // 使われている材料のリスト
  final String category;  // メニューのカテゴリー(主食・副菜など)

  /* コンストラクター */
  Dish(this.dish,
       this.category);

  /* JSONからの読み取り */
  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);

  /* 各パラメータgetter */

  /* メニューの中にアレルギーを使用した食材があるかを調べる */
  List<FoodStuff> get allergies {
    List<FoodStuff> result = [];
    for (var i = 0; i < dish.length; i++) {
      if(dish[i].allergy) result.add(dish[i]);
    }
    return result;
  }

  /* メニューの中の熱加工食材を調べる */
  List<FoodStuff> get heats {
    List<FoodStuff> result = [];
    for (var i = 0; i < dish.length; i++) {
      if(dish[i].heat) result.add(dish[i]);
    }
    return result;
  }

  /* 各栄養素の合計値を調べる */
  double get dishEnergy {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].energy;
    }
    return result;
  }

  double get dishProtein {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].protein;
    }
    return result;
  }

  double get dishLipid {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].lipid;
    }
    return result;
  }

  double get dishCarbohydrate {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].carbohydrate;
    }
    return result;
  }

  double get dishSodium {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].sodium;
    }
    return result;
  }

  double get dishCalcium {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].calcium;
    }
    return result;
  }

  double get dishMagnesium {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].magnesium;
    }
    return result;
  }

  double get dishIron {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].iron;
    }
    return result;
  }

  double get dishZinc {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].zinc;
    }
    return result;
  }

  double get dishRetinol {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].retinol;
    }
    return result;
  }

  double get dishVitaminB1 {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].vitaminB1;
    }
    return result;
  }

  double get dishVitaminB2 {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].vitaminB2;
    }
    return result;
  }

  double get dishVitaminC {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].vitaminC;
    }
    return result;
  }

  double get dishDietaryFiber {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].dietaryFiber;
    }
    return result;
  }

  double get dishSalt {
    var result = 0.0;
    for (var i = 0; i < dish.length; i++) {
      result += dish[i].salt;
    }
    return result;
  }
}
