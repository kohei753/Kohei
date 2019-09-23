// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) {
  return Child(
    json['name'] as String,
    json['school'] as String,
    json['schoolYear'] as int,
    json['sex'] as String,
  );
}

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'name': instance.name,
      'school': instance.school,
      'schoolYear': instance.schoolYear,
      'sex': instance.sex,
    };
