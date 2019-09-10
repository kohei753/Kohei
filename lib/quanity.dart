/* 分量・個数に関するクラス */

class Quantity {
  /* 変数宣言 */
  final double number;  // 個数(設定がない場合：null)
  final double gram;  // 分量(g)

  /* コンストラクター */
  Quantity(this.number,
           this.gram);
}