/* 各食材に関するクラス */

import 'quanity.dart';

class FoodStuff {
  /* 変数宣言 */
  final String name;  // 食品名

  final bool allergy; // アレルギー食材か
  final bool piece;  // 個付きか
  final Quantity quantity;  //  分量
  final bool heat;  // 熱加工しているか

  final double energy; // エネルギー
  final double protein; // タンパク質
  final double lipid; // 脂質
  final double carbohydrate;  // 炭水化物
  final double sodium;  // ナトリウム
  final double calcium; // カルシウム
  final double magnesium; // マグネシウム
  final double iron;  // 鉄分
  final double zinc;  // 亜鉛
  final double retinol; // レチノール活性当量(ビタミンA)
  final double vitaminB1; // ビタミンB1
  final double vitaminB2; // ビタミンB2
  final double vitaminC;  // ビタミンC
  final double dietaryFiber;  // 食物繊維
  final double salt;  // 食塩相当量

  /* コンストラクター */
  FoodStuff(
      this.name,
      this.allergy,
      this.piece,
      this.quantity,
      this.heat,
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
      this.salt
      );
}