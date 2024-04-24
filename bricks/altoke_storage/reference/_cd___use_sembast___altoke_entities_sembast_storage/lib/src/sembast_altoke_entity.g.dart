// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sembast_altoke_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SembastAltokeEntity _$SembastAltokeEntityFromJson(Map json) => $checkedCreate(
      'SembastAltokeEntity',
      json,
      ($checkedConvert) {
        final val = SembastAltokeEntity(
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$SembastAltokeEntityToJson(
        SembastAltokeEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };
