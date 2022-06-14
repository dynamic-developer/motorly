part of '../database_provider.dart';

class HistoryOffers extends Table {
  IntColumn get id => integer()();

  Set<Column> get primaryKey => {id};

  TextColumn get offer => text()();

  DateTimeColumn get createdAt => dateTime()();
}
