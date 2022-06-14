part of '../database_provider.dart';

class Makes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().nullable()();
}
