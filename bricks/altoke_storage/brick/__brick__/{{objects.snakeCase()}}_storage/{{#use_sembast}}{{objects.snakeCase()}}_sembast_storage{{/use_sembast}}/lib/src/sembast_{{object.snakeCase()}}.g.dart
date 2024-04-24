// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sembast_{{object.snakeCase()}}.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sembast{{object.pascalCase()}} _$Sembast{{object.pascalCase()}}FromJson(Map json) => $checkedCreate(
      'Sembast{{object.pascalCase()}}',
      json,
      ($checkedConvert) {
        final val = Sembast{{object.pascalCase()}}(
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$Sembast{{object.pascalCase()}}ToJson(
        Sembast{{object.pascalCase()}} instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };
