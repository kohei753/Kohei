// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DRI _$DRIFromJson(Map<String, dynamic> json) {
  return DRI(
    json['protein'] == null
        ? null
        : YearStandard.fromJson(json['protein'] as Map<String, dynamic>),
    json['lipid'] == null
        ? null
        : YearStandard.fromJson(json['lipid'] as Map<String, dynamic>),
    json['carbohydrate'] == null
        ? null
        : YearStandard.fromJson(json['carbohydrate'] as Map<String, dynamic>),
    json['sodium'] == null
        ? null
        : YearStandard.fromJson(json['sodium'] as Map<String, dynamic>),
    json['calcium'] == null
        ? null
        : YearStandard.fromJson(json['calcium'] as Map<String, dynamic>),
    json['magnesium'] == null
        ? null
        : YearStandard.fromJson(json['magnesium'] as Map<String, dynamic>),
    json['iron'] == null
        ? null
        : YearStandard.fromJson(json['iron'] as Map<String, dynamic>),
    json['zinc'] == null
        ? null
        : YearStandard.fromJson(json['zinc'] as Map<String, dynamic>),
    json['retinol'] == null
        ? null
        : YearStandard.fromJson(json['retinol'] as Map<String, dynamic>),
    json['vitaminB1'] == null
        ? null
        : YearStandard.fromJson(json['vitaminB1'] as Map<String, dynamic>),
    json['vitaminB2'] == null
        ? null
        : YearStandard.fromJson(json['vitaminB2'] as Map<String, dynamic>),
    json['vitaminC'] == null
        ? null
        : YearStandard.fromJson(json['vitaminC'] as Map<String, dynamic>),
    json['dietaryFiber'] == null
        ? null
        : YearStandard.fromJson(json['dietaryFiber'] as Map<String, dynamic>),
    json['salt'] == null
        ? null
        : YearStandard.fromJson(json['salt'] as Map<String, dynamic>),
  );
}

YearStandard _$YearStandardFromJson(Map<String, dynamic> json) {
  return YearStandard(
    json['primary1'] == null
        ? null
        : GenderStandard.fromJson(json['primary1'] as Map<String, dynamic>),
    json['primary2'] == null
        ? null
        : GenderStandard.fromJson(json['primary2'] as Map<String, dynamic>),
    json['primary3'] == null
        ? null
        : GenderStandard.fromJson(json['primary3'] as Map<String, dynamic>),
    json['primary4'] == null
        ? null
        : GenderStandard.fromJson(json['primary4'] as Map<String, dynamic>),
    json['primary5'] == null
        ? null
        : GenderStandard.fromJson(json['primary5'] as Map<String, dynamic>),
    json['primary6'] == null
        ? null
        : GenderStandard.fromJson(json['primary6'] as Map<String, dynamic>),
    json['junior1'] == null
        ? null
        : GenderStandard.fromJson(json['junior1'] as Map<String, dynamic>),
    json['junior2'] == null
        ? null
        : GenderStandard.fromJson(json['junior2'] as Map<String, dynamic>),
    json['junior3'] == null
        ? null
        : GenderStandard.fromJson(json['junior3'] as Map<String, dynamic>),
  );
}

GenderStandard _$GenderStandardFromJson(Map<String, dynamic> json) {
  return GenderStandard(
    json['man'] as double,
    json['woman'] as double,
  );
}
