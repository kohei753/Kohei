// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    Menu._parseDay(json['day']),
    json['school'] as String,
    (json['menu'] as List)
        ?.map(
            (e) => e == null ? null : Dish.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Menus _$MenusFromJson(Map<String, dynamic> json) {
  return Menus(
    (json['menus'] as List)
        ?.map(
            (e) => e == null ? null : Menu.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
