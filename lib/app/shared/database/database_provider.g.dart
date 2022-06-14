// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Make extends DataClass implements Insertable<Make> {
  final int id;
  final String name;
  Make({@required this.id, this.name});
  factory Make.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Make(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  MakesCompanion toCompanion(bool nullToAbsent) {
    return MakesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory Make.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Make(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Make copyWith({int id, String name}) => Make(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Make(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Make && other.id == this.id && other.name == this.name);
}

class MakesCompanion extends UpdateCompanion<Make> {
  final Value<int> id;
  final Value<String> name;
  const MakesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  MakesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<Make> custom({
    Expression<int> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  MakesCompanion copyWith({Value<int> id, Value<String> name}) {
    return MakesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MakesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $MakesTable extends Makes with TableInfo<$MakesTable, Make> {
  final GeneratedDatabase _db;
  final String _alias;
  $MakesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      _name ??= GeneratedColumn<String>('name', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'makes';
  @override
  String get actualTableName => 'makes';
  @override
  VerificationContext validateIntegrity(Insertable<Make> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Make map(Map<String, dynamic> data, {String tablePrefix}) {
    return Make.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MakesTable createAlias(String alias) {
    return $MakesTable(_db, alias);
  }
}

class Model extends DataClass implements Insertable<Model> {
  final int id;
  final String name;
  Model({@required this.id, this.name});
  factory Model.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Model(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  ModelsCompanion toCompanion(bool nullToAbsent) {
    return ModelsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory Model.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Model(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Model copyWith({int id, String name}) => Model(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Model(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Model && other.id == this.id && other.name == this.name);
}

class ModelsCompanion extends UpdateCompanion<Model> {
  final Value<int> id;
  final Value<String> name;
  const ModelsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ModelsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<Model> custom({
    Expression<int> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ModelsCompanion copyWith({Value<int> id, Value<String> name}) {
    return ModelsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ModelsTable extends Models with TableInfo<$ModelsTable, Model> {
  final GeneratedDatabase _db;
  final String _alias;
  $ModelsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      _name ??= GeneratedColumn<String>('name', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'models';
  @override
  String get actualTableName => 'models';
  @override
  VerificationContext validateIntegrity(Insertable<Model> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Model map(Map<String, dynamic> data, {String tablePrefix}) {
    return Model.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelsTable createAlias(String alias) {
    return $ModelsTable(_db, alias);
  }
}

class HistoryOffer extends DataClass implements Insertable<HistoryOffer> {
  final int id;
  final String offer;
  final DateTime createdAt;
  HistoryOffer(
      {@required this.id, @required this.offer, @required this.createdAt});
  factory HistoryOffer.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return HistoryOffer(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      offer: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}offer']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || offer != null) {
      map['offer'] = Variable<String>(offer);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  HistoryOffersCompanion toCompanion(bool nullToAbsent) {
    return HistoryOffersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      offer:
          offer == null && nullToAbsent ? const Value.absent() : Value(offer),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory HistoryOffer.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HistoryOffer(
      id: serializer.fromJson<int>(json['id']),
      offer: serializer.fromJson<String>(json['offer']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'offer': serializer.toJson<String>(offer),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HistoryOffer copyWith({int id, String offer, DateTime createdAt}) =>
      HistoryOffer(
        id: id ?? this.id,
        offer: offer ?? this.offer,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('HistoryOffer(')
          ..write('id: $id, ')
          ..write('offer: $offer, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, offer, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryOffer &&
          other.id == this.id &&
          other.offer == this.offer &&
          other.createdAt == this.createdAt);
}

class HistoryOffersCompanion extends UpdateCompanion<HistoryOffer> {
  final Value<int> id;
  final Value<String> offer;
  final Value<DateTime> createdAt;
  const HistoryOffersCompanion({
    this.id = const Value.absent(),
    this.offer = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HistoryOffersCompanion.insert({
    this.id = const Value.absent(),
    @required String offer,
    @required DateTime createdAt,
  })  : offer = Value(offer),
        createdAt = Value(createdAt);
  static Insertable<HistoryOffer> custom({
    Expression<int> id,
    Expression<String> offer,
    Expression<DateTime> createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (offer != null) 'offer': offer,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HistoryOffersCompanion copyWith(
      {Value<int> id, Value<String> offer, Value<DateTime> createdAt}) {
    return HistoryOffersCompanion(
      id: id ?? this.id,
      offer: offer ?? this.offer,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (offer.present) {
      map['offer'] = Variable<String>(offer.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryOffersCompanion(')
          ..write('id: $id, ')
          ..write('offer: $offer, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HistoryOffersTable extends HistoryOffers
    with TableInfo<$HistoryOffersTable, HistoryOffer> {
  final GeneratedDatabase _db;
  final String _alias;
  $HistoryOffersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _offerMeta = const VerificationMeta('offer');
  GeneratedColumn<String> _offer;
  @override
  GeneratedColumn<String> get offer =>
      _offer ??= GeneratedColumn<String>('offer', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedColumn<DateTime> _createdAt;
  @override
  GeneratedColumn<DateTime> get createdAt =>
      _createdAt ??= GeneratedColumn<DateTime>('created_at', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, offer, createdAt];
  @override
  String get aliasedName => _alias ?? 'history_offers';
  @override
  String get actualTableName => 'history_offers';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryOffer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('offer')) {
      context.handle(
          _offerMeta, offer.isAcceptableOrUnknown(data['offer'], _offerMeta));
    } else if (isInserting) {
      context.missing(_offerMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryOffer map(Map<String, dynamic> data, {String tablePrefix}) {
    return HistoryOffer.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HistoryOffersTable createAlias(String alias) {
    return $HistoryOffersTable(_db, alias);
  }
}

abstract class _$DatabaseProvider extends GeneratedDatabase {
  _$DatabaseProvider(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MakesTable _makes;
  $MakesTable get makes => _makes ??= $MakesTable(this);
  $ModelsTable _models;
  $ModelsTable get models => _models ??= $ModelsTable(this);
  $HistoryOffersTable _historyOffers;
  $HistoryOffersTable get historyOffers =>
      _historyOffers ??= $HistoryOffersTable(this);
  MakesDao _makesDao;
  MakesDao get makesDao => _makesDao ??= MakesDao(this as DatabaseProvider);
  ModelsDao _modelsDao;
  ModelsDao get modelsDao => _modelsDao ??= ModelsDao(this as DatabaseProvider);
  HistoryOffersDao _historyOffersDao;
  HistoryOffersDao get historyOffersDao =>
      _historyOffersDao ??= HistoryOffersDao(this as DatabaseProvider);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [makes, models, historyOffers];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$MakesDaoMixin on DatabaseAccessor<DatabaseProvider> {
  $MakesTable get makes => attachedDatabase.makes;
}
mixin _$ModelsDaoMixin on DatabaseAccessor<DatabaseProvider> {
  $ModelsTable get models => attachedDatabase.models;
}
mixin _$HistoryOffersDaoMixin on DatabaseAccessor<DatabaseProvider> {
  $HistoryOffersTable get historyOffers => attachedDatabase.historyOffers;
}
