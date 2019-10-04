// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foodStuff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quantity _$QuantityFromJson(Map<String, dynamic> json) {
  return Quantity(
    (json['number'] as num)?.toDouble(),
    (json['gram'] as num)?.toDouble(),
  );
}

FoodStuff _$FoodStuffFromJson(Map<String, dynamic> json) {
  return FoodStuff(
    json['material'] as String,
    FoodStuff._parseBoolean(json['allergy']),
    FoodStuff._parseBoolean(json['piece']),
    json['quantity'] == null
        ? null
        : Quantity.fromJson(json['quantity'] as Map<String, dynamic>),
    FoodStuff._parseBoolean(json['heat']),
    (json['energy'] as num)?.toDouble(),
    (json['protein'] as num)?.toDouble(),
    (json['lipid'] as num)?.toDouble(),
    (json['carbohydrate'] as num)?.toDouble(),
    (json['sodium'] as num)?.toDouble(),
    (json['calcium'] as num)?.toDouble(),
    (json['magnesium'] as num)?.toDouble(),
    (json['iron'] as num)?.toDouble(),
    (json['zinc'] as num)?.toDouble(),
    (json['retinol'] as num)?.toDouble(),
    (json['vitaminB1'] as num)?.toDouble(),
    (json['vitaminB2'] as num)?.toDouble(),
    (json['vitaminC'] as num)?.toDouble(),
    (json['dietaryFiber'] as num)?.toDouble(),
    (json['salt'] as num)?.toDouble(),
  );
}
