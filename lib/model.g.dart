// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFuelDataModelCollection on Isar {
  IsarCollection<FuelDataModel> get fuelDataModels => this.collection();
}

const FuelDataModelSchema = CollectionSchema(
  name: r'FuelDataModel',
  id: 2736329772500586394,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'distanceByFuel': PropertySchema(
      id: 1,
      name: r'distanceByFuel',
      type: IsarType.double,
    ),
    r'distanceTravelled': PropertySchema(
      id: 2,
      name: r'distanceTravelled',
      type: IsarType.double,
    ),
    r'fuelPrice': PropertySchema(
      id: 3,
      name: r'fuelPrice',
      type: IsarType.double,
    ),
    r'isFueledUp': PropertySchema(
      id: 4,
      name: r'isFueledUp',
      type: IsarType.bool,
    )
  },
  estimateSize: _fuelDataModelEstimateSize,
  serialize: _fuelDataModelSerialize,
  deserialize: _fuelDataModelDeserialize,
  deserializeProp: _fuelDataModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _fuelDataModelGetId,
  getLinks: _fuelDataModelGetLinks,
  attach: _fuelDataModelAttach,
  version: '3.1.0+1',
);

int _fuelDataModelEstimateSize(
  FuelDataModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _fuelDataModelSerialize(
  FuelDataModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeDouble(offsets[1], object.distanceByFuel);
  writer.writeDouble(offsets[2], object.distanceTravelled);
  writer.writeDouble(offsets[3], object.fuelPrice);
  writer.writeBool(offsets[4], object.isFueledUp);
}

FuelDataModel _fuelDataModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FuelDataModel(
    date: reader.readDateTime(offsets[0]),
    distanceByFuel: reader.readDouble(offsets[1]),
    distanceTravelled: reader.readDouble(offsets[2]),
    fuelPrice: reader.readDouble(offsets[3]),
    id: id,
    isFueledUp: reader.readBoolOrNull(offsets[4]) ?? false,
  );
  return object;
}

P _fuelDataModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fuelDataModelGetId(FuelDataModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fuelDataModelGetLinks(FuelDataModel object) {
  return [];
}

void _fuelDataModelAttach(
    IsarCollection<dynamic> col, Id id, FuelDataModel object) {}

extension FuelDataModelQueryWhereSort
    on QueryBuilder<FuelDataModel, FuelDataModel, QWhere> {
  QueryBuilder<FuelDataModel, FuelDataModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FuelDataModelQueryWhere
    on QueryBuilder<FuelDataModel, FuelDataModel, QWhereClause> {
  QueryBuilder<FuelDataModel, FuelDataModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterWhereClause> idBetween(
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

extension FuelDataModelQueryFilter
    on QueryBuilder<FuelDataModel, FuelDataModel, QFilterCondition> {
  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      distanceByFuelEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanceByFuel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      distanceByFuelGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanceByFuel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      distanceByFuelLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanceByFuel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      distanceByFuelBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanceByFuel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      distanceTravelledEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanceTravelled',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      distanceTravelledGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanceTravelled',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      distanceTravelledLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanceTravelled',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      distanceTravelledBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanceTravelled',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      fuelPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fuelPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      fuelPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fuelPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      fuelPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fuelPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      fuelPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fuelPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
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

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterFilterCondition>
      isFueledUpEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFueledUp',
        value: value,
      ));
    });
  }
}

extension FuelDataModelQueryObject
    on QueryBuilder<FuelDataModel, FuelDataModel, QFilterCondition> {}

extension FuelDataModelQueryLinks
    on QueryBuilder<FuelDataModel, FuelDataModel, QFilterCondition> {}

extension FuelDataModelQuerySortBy
    on QueryBuilder<FuelDataModel, FuelDataModel, QSortBy> {
  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      sortByDistanceByFuel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceByFuel', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      sortByDistanceByFuelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceByFuel', Sort.desc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      sortByDistanceTravelled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceTravelled', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      sortByDistanceTravelledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceTravelled', Sort.desc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> sortByFuelPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelPrice', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      sortByFuelPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelPrice', Sort.desc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> sortByIsFueledUp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFueledUp', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      sortByIsFueledUpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFueledUp', Sort.desc);
    });
  }
}

extension FuelDataModelQuerySortThenBy
    on QueryBuilder<FuelDataModel, FuelDataModel, QSortThenBy> {
  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      thenByDistanceByFuel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceByFuel', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      thenByDistanceByFuelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceByFuel', Sort.desc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      thenByDistanceTravelled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceTravelled', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      thenByDistanceTravelledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceTravelled', Sort.desc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> thenByFuelPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelPrice', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      thenByFuelPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelPrice', Sort.desc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy> thenByIsFueledUp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFueledUp', Sort.asc);
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QAfterSortBy>
      thenByIsFueledUpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFueledUp', Sort.desc);
    });
  }
}

extension FuelDataModelQueryWhereDistinct
    on QueryBuilder<FuelDataModel, FuelDataModel, QDistinct> {
  QueryBuilder<FuelDataModel, FuelDataModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QDistinct>
      distinctByDistanceByFuel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceByFuel');
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QDistinct>
      distinctByDistanceTravelled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceTravelled');
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QDistinct> distinctByFuelPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fuelPrice');
    });
  }

  QueryBuilder<FuelDataModel, FuelDataModel, QDistinct> distinctByIsFueledUp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFueledUp');
    });
  }
}

extension FuelDataModelQueryProperty
    on QueryBuilder<FuelDataModel, FuelDataModel, QQueryProperty> {
  QueryBuilder<FuelDataModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FuelDataModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<FuelDataModel, double, QQueryOperations>
      distanceByFuelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceByFuel');
    });
  }

  QueryBuilder<FuelDataModel, double, QQueryOperations>
      distanceTravelledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceTravelled');
    });
  }

  QueryBuilder<FuelDataModel, double, QQueryOperations> fuelPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fuelPrice');
    });
  }

  QueryBuilder<FuelDataModel, bool, QQueryOperations> isFueledUpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFueledUp');
    });
  }
}
