// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SLIS _$SLISFromJson(Map<String, dynamic> json) {
  return SLIS(
    json['energy'] == null
        ? null
        : NutrientSLIS.fromJson(json['energy'] as Map<String, dynamic>),
    json['protein'] == null
        ? null
        : NutrientSLIS.fromJson(json['protein'] as Map<String, dynamic>),
    json['lipid'] == null
        ? null
        : NutrientSLIS.fromJson(json['lipid'] as Map<String, dynamic>),
    json['carbohydrate'] == null
        ? null
        : NutrientSLIS.fromJson(json['carbohydrate'] as Map<String, dynamic>),
    json['sodium'] == null
        ? null
        : NutrientSLIS.fromJson(json['sodium'] as Map<String, dynamic>),
    json['calcium'] == null
        ? null
        : NutrientSLIS.fromJson(json['calcium'] as Map<String, dynamic>),
    json['magnesium'] == null
        ? null
        : NutrientSLIS.fromJson(json['magnesium'] as Map<String, dynamic>),
    json['iron'] == null
        ? null
        : NutrientSLIS.fromJson(json['iron'] as Map<String, dynamic>),
    json['zinc'] == null
        ? null
        : NutrientSLIS.fromJson(json['zinc'] as Map<String, dynamic>),
    json['retinol'] == null
        ? null
        : NutrientSLIS.fromJson(json['retinol'] as Map<String, dynamic>),
    json['vitaminB1'] == null
        ? null
        : NutrientSLIS.fromJson(json['vitaminB1'] as Map<String, dynamic>),
    json['vitaminB2'] == null
        ? null
        : NutrientSLIS.fromJson(json['vitaminB2'] as Map<String, dynamic>),
    json['vitaminC'] == null
        ? null
        : NutrientSLIS.fromJson(json['vitaminC'] as Map<String, dynamic>),
    json['dietaryFiber'] == null
        ? null
        : NutrientSLIS.fromJson(json['dietaryFiber'] as Map<String, dynamic>),
    json['salt'] == null
        ? null
        : NutrientSLIS.fromJson(json['salt'] as Map<String, dynamic>),
  );
}

NutrientSLIS _$NutrientSLISFromJson(Map<String, dynamic> json) {
  return NutrientSLIS(
    (json['low'] as num)?.toDouble(),
    (json['middle'] as num)?.toDouble(),
    (json['high'] as num)?.toDouble(),
    (json['junior'] as num)?.toDouble(),
  )..years =
      (json['years'] as List)?.map((e) => (e as num)?.toDouble())?.toList();
}
