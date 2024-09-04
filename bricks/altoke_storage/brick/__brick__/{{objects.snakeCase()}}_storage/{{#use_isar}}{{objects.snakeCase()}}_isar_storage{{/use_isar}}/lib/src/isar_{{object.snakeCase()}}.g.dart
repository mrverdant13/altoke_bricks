// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_{{object.snakeCase()}}.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsar{{object.pascalCase()}}Collection on Isar {
  IsarCollection<Isar{{object.pascalCase()}}> get isar{{objects.pascalCase()}} => this.collection();
}

const Isar{{object.pascalCase()}}Schema = CollectionSchema(
  name: r'Isar{{object.pascalCase()}}',
  id: -1728968747948670997,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _isar{{object.pascalCase()}}EstimateSize,
  serialize: _isar{{object.pascalCase()}}Serialize,
  deserialize: _isar{{object.pascalCase()}}Deserialize,
  deserializeProp: _isar{{object.pascalCase()}}DeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isar{{object.pascalCase()}}GetId,
  getLinks: _isar{{object.pascalCase()}}GetLinks,
  attach: _isar{{object.pascalCase()}}Attach,
  version: '3.1.8',
);

int _isar{{object.pascalCase()}}EstimateSize(
  Isar{{object.pascalCase()}} object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _isar{{object.pascalCase()}}Serialize(
  Isar{{object.pascalCase()}} object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeString(offsets[1], object.name);
}

Isar{{object.pascalCase()}} _isar{{object.pascalCase()}}Deserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Isar{{object.pascalCase()}}();
  object.description = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  return object;
}

P _isar{{object.pascalCase()}}DeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isar{{object.pascalCase()}}GetId(Isar{{object.pascalCase()}} object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isar{{object.pascalCase()}}GetLinks(Isar{{object.pascalCase()}} object) {
  return [];
}

void _isar{{object.pascalCase()}}Attach(
    IsarCollection<dynamic> col, Id id, Isar{{object.pascalCase()}} object) {
  object.id = id;
}

extension Isar{{object.pascalCase()}}QueryWhereSort
    on QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QWhere> {
  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension Isar{{object.pascalCase()}}QueryWhere
    on QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QWhereClause> {
  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension Isar{{object.pascalCase()}}QueryFilter
    on QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QFilterCondition> {
  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension Isar{{object.pascalCase()}}QueryObject
    on QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QFilterCondition> {}

extension Isar{{object.pascalCase()}}QueryLinks
    on QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QFilterCondition> {}

extension Isar{{object.pascalCase()}}QuerySortBy
    on QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QSortBy> {
  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension Isar{{object.pascalCase()}}QuerySortThenBy
    on QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QSortThenBy> {
  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension Isar{{object.pascalCase()}}QueryWhereDistinct
    on QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QDistinct> {
  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension Isar{{object.pascalCase()}}QueryProperty
    on QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QQueryProperty> {
  QueryBuilder<Isar{{object.pascalCase()}}, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Isar{{object.pascalCase()}}, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
