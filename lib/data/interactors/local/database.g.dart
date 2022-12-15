// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SearchItem extends DataClass implements Insertable<SearchItem> {
  final int id;
  final String category;
  SearchItem({required this.id, required this.category});
  factory SearchItem.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SearchItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    return map;
  }

  SearchItemsCompanion toCompanion(bool nullToAbsent) {
    return SearchItemsCompanion(
      id: Value(id),
      category: Value(category),
    );
  }

  factory SearchItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchItem(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
    };
  }

  SearchItem copyWith({int? id, String? category}) => SearchItem(
        id: id ?? this.id,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('SearchItem(')
          ..write('id: $id, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchItem &&
          other.id == this.id &&
          other.category == this.category);
}

class SearchItemsCompanion extends UpdateCompanion<SearchItem> {
  final Value<int> id;
  final Value<String> category;
  const SearchItemsCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
  });
  SearchItemsCompanion.insert({
    this.id = const Value.absent(),
    required String category,
  }) : category = Value(category);
  static Insertable<SearchItem> custom({
    Expression<int>? id,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
    });
  }

  SearchItemsCompanion copyWith({Value<int>? id, Value<String>? category}) {
    return SearchItemsCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchItemsCompanion(')
          ..write('id: $id, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $SearchItemsTable extends SearchItems
    with TableInfo<$SearchItemsTable, SearchItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, category];
  @override
  String get aliasedName => _alias ?? 'search_items';
  @override
  String get actualTableName => 'search_items';
  @override
  VerificationContext validateIntegrity(Insertable<SearchItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SearchItem.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SearchItemsTable createAlias(String alias) {
    return $SearchItemsTable(attachedDatabase, alias);
  }
}

class FavouritePlacesItem extends DataClass
    implements Insertable<FavouritePlacesItem> {
  final int id;
  final String url;
  final String type;
  final String name;
  final bool plan;
  final DateTime time;
  FavouritePlacesItem(
      {required this.id,
      required this.url,
      required this.type,
      required this.name,
      required this.plan,
      required this.time});
  factory FavouritePlacesItem.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavouritePlacesItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      plan: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}plan'])!,
      time: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['url'] = Variable<String>(url);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['plan'] = Variable<bool>(plan);
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  FavouritePlacesItemsCompanion toCompanion(bool nullToAbsent) {
    return FavouritePlacesItemsCompanion(
      id: Value(id),
      url: Value(url),
      type: Value(type),
      name: Value(name),
      plan: Value(plan),
      time: Value(time),
    );
  }

  factory FavouritePlacesItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavouritePlacesItem(
      id: serializer.fromJson<int>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      plan: serializer.fromJson<bool>(json['plan']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'url': serializer.toJson<String>(url),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'plan': serializer.toJson<bool>(plan),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  FavouritePlacesItem copyWith(
          {int? id,
          String? url,
          String? type,
          String? name,
          bool? plan,
          DateTime? time}) =>
      FavouritePlacesItem(
        id: id ?? this.id,
        url: url ?? this.url,
        type: type ?? this.type,
        name: name ?? this.name,
        plan: plan ?? this.plan,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('FavouritePlacesItem(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('plan: $plan, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, url, type, name, plan, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavouritePlacesItem &&
          other.id == this.id &&
          other.url == this.url &&
          other.type == this.type &&
          other.name == this.name &&
          other.plan == this.plan &&
          other.time == this.time);
}

class FavouritePlacesItemsCompanion
    extends UpdateCompanion<FavouritePlacesItem> {
  final Value<int> id;
  final Value<String> url;
  final Value<String> type;
  final Value<String> name;
  final Value<bool> plan;
  final Value<DateTime> time;
  const FavouritePlacesItemsCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.plan = const Value.absent(),
    this.time = const Value.absent(),
  });
  FavouritePlacesItemsCompanion.insert({
    required int id,
    required String url,
    required String type,
    required String name,
    required bool plan,
    required DateTime time,
  })  : id = Value(id),
        url = Value(url),
        type = Value(type),
        name = Value(name),
        plan = Value(plan),
        time = Value(time);
  static Insertable<FavouritePlacesItem> custom({
    Expression<int>? id,
    Expression<String>? url,
    Expression<String>? type,
    Expression<String>? name,
    Expression<bool>? plan,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (plan != null) 'plan': plan,
      if (time != null) 'time': time,
    });
  }

  FavouritePlacesItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? url,
      Value<String>? type,
      Value<String>? name,
      Value<bool>? plan,
      Value<DateTime>? time}) {
    return FavouritePlacesItemsCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      type: type ?? this.type,
      name: name ?? this.name,
      plan: plan ?? this.plan,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (plan.present) {
      map['plan'] = Variable<bool>(plan.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavouritePlacesItemsCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('plan: $plan, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $FavouritePlacesItemsTable extends FavouritePlacesItems
    with TableInfo<$FavouritePlacesItemsTable, FavouritePlacesItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavouritePlacesItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _planMeta = const VerificationMeta('plan');
  @override
  late final GeneratedColumn<bool?> plan = GeneratedColumn<bool?>(
      'plan', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK ("plan" IN (0, 1))');
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime?> time = GeneratedColumn<DateTime?>(
      'time', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, url, type, name, plan, time];
  @override
  String get aliasedName => _alias ?? 'favourite_places_items';
  @override
  String get actualTableName => 'favourite_places_items';
  @override
  VerificationContext validateIntegrity(
      Insertable<FavouritePlacesItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('plan')) {
      context.handle(
          _planMeta, plan.isAcceptableOrUnknown(data['plan']!, _planMeta));
    } else if (isInserting) {
      context.missing(_planMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  FavouritePlacesItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavouritePlacesItem.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavouritePlacesItemsTable createAlias(String alias) {
    return $FavouritePlacesItemsTable(attachedDatabase, alias);
  }
}

class VisitedPlacesItem extends DataClass
    implements Insertable<VisitedPlacesItem> {
  final int id;
  final String url;
  final String type;
  final String name;
  final DateTime date;
  final DateTime timeOpen;
  VisitedPlacesItem(
      {required this.id,
      required this.url,
      required this.type,
      required this.name,
      required this.date,
      required this.timeOpen});
  factory VisitedPlacesItem.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return VisitedPlacesItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      timeOpen: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time_open'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['url'] = Variable<String>(url);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['date'] = Variable<DateTime>(date);
    map['time_open'] = Variable<DateTime>(timeOpen);
    return map;
  }

  VisitedPlacesItemsCompanion toCompanion(bool nullToAbsent) {
    return VisitedPlacesItemsCompanion(
      id: Value(id),
      url: Value(url),
      type: Value(type),
      name: Value(name),
      date: Value(date),
      timeOpen: Value(timeOpen),
    );
  }

  factory VisitedPlacesItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisitedPlacesItem(
      id: serializer.fromJson<int>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime>(json['date']),
      timeOpen: serializer.fromJson<DateTime>(json['timeOpen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'url': serializer.toJson<String>(url),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime>(date),
      'timeOpen': serializer.toJson<DateTime>(timeOpen),
    };
  }

  VisitedPlacesItem copyWith(
          {int? id,
          String? url,
          String? type,
          String? name,
          DateTime? date,
          DateTime? timeOpen}) =>
      VisitedPlacesItem(
        id: id ?? this.id,
        url: url ?? this.url,
        type: type ?? this.type,
        name: name ?? this.name,
        date: date ?? this.date,
        timeOpen: timeOpen ?? this.timeOpen,
      );
  @override
  String toString() {
    return (StringBuffer('VisitedPlacesItem(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('timeOpen: $timeOpen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, url, type, name, date, timeOpen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisitedPlacesItem &&
          other.id == this.id &&
          other.url == this.url &&
          other.type == this.type &&
          other.name == this.name &&
          other.date == this.date &&
          other.timeOpen == this.timeOpen);
}

class VisitedPlacesItemsCompanion extends UpdateCompanion<VisitedPlacesItem> {
  final Value<int> id;
  final Value<String> url;
  final Value<String> type;
  final Value<String> name;
  final Value<DateTime> date;
  final Value<DateTime> timeOpen;
  const VisitedPlacesItemsCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.timeOpen = const Value.absent(),
  });
  VisitedPlacesItemsCompanion.insert({
    required int id,
    required String url,
    required String type,
    required String name,
    required DateTime date,
    required DateTime timeOpen,
  })  : id = Value(id),
        url = Value(url),
        type = Value(type),
        name = Value(name),
        date = Value(date),
        timeOpen = Value(timeOpen);
  static Insertable<VisitedPlacesItem> custom({
    Expression<int>? id,
    Expression<String>? url,
    Expression<String>? type,
    Expression<String>? name,
    Expression<DateTime>? date,
    Expression<DateTime>? timeOpen,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (timeOpen != null) 'time_open': timeOpen,
    });
  }

  VisitedPlacesItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? url,
      Value<String>? type,
      Value<String>? name,
      Value<DateTime>? date,
      Value<DateTime>? timeOpen}) {
    return VisitedPlacesItemsCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      type: type ?? this.type,
      name: name ?? this.name,
      date: date ?? this.date,
      timeOpen: timeOpen ?? this.timeOpen,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (timeOpen.present) {
      map['time_open'] = Variable<DateTime>(timeOpen.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitedPlacesItemsCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('timeOpen: $timeOpen')
          ..write(')'))
        .toString();
  }
}

class $VisitedPlacesItemsTable extends VisitedPlacesItems
    with TableInfo<$VisitedPlacesItemsTable, VisitedPlacesItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisitedPlacesItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _timeOpenMeta = const VerificationMeta('timeOpen');
  @override
  late final GeneratedColumn<DateTime?> timeOpen = GeneratedColumn<DateTime?>(
      'time_open', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, url, type, name, date, timeOpen];
  @override
  String get aliasedName => _alias ?? 'visited_places_items';
  @override
  String get actualTableName => 'visited_places_items';
  @override
  VerificationContext validateIntegrity(Insertable<VisitedPlacesItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('time_open')) {
      context.handle(_timeOpenMeta,
          timeOpen.isAcceptableOrUnknown(data['time_open']!, _timeOpenMeta));
    } else if (isInserting) {
      context.missing(_timeOpenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  VisitedPlacesItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return VisitedPlacesItem.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VisitedPlacesItemsTable createAlias(String alias) {
    return $VisitedPlacesItemsTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SearchItemsTable searchItems = $SearchItemsTable(this);
  late final $FavouritePlacesItemsTable favouritePlacesItems =
      $FavouritePlacesItemsTable(this);
  late final $VisitedPlacesItemsTable visitedPlacesItems =
      $VisitedPlacesItemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [searchItems, favouritePlacesItems, visitedPlacesItems];
}
