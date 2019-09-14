// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    json['day'] == null ? null : DateTime.parse(json['day'] as String),
    json['school'] as String,
    (json['menu'] as List)
        ?.map(
            (e) => e == null ? null : Dish.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
