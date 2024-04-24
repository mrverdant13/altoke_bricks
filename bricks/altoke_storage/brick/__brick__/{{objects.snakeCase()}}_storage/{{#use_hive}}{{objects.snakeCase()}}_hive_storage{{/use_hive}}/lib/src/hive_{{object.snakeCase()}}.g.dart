// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_{{object.snakeCase()}}.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hive{{object.pascalCase()}} _$Hive{{object.pascalCase()}}FromJson(Map json) => $checkedCreate(
      'Hive{{object.pascalCase()}}',
      json,
      ($checkedConvert) {
        final val = Hive{{object.pascalCase()}}(
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$Hive{{object.pascalCase()}}ToJson(Hive{{object.pascalCase()}} instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };
