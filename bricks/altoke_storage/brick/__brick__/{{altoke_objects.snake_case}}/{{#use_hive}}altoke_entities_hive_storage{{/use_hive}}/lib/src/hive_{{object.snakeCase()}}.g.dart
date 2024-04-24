// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_{{object.snakeCase()}}.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HiveAltokeEntity _$HiveAltokeEntityFromJson(Map json) => $checkedCreate(
      'HiveAltokeEntity',
      json,
      ($checkedConvert) {
        final val = HiveAltokeEntity(
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$HiveAltokeEntityToJson(HiveAltokeEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };
