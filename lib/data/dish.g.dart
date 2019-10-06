// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package:sample/data/dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dish _$DishFromJson(Map<String, dynamic> json) {
  return Dish(
    json['name'] as String,
    (json['dish'] as List)
        ?.map((e) =>
            e == null ? null : FoodStuff.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['category'] as String,
  );
}
