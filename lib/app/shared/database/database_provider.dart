import 'dart:async';

import 'package:moor_flutter/moor_flutter.dart';

part 'database_provider.g.dart';

part 'tables/makes_table.dart';
part 'tables/models_table.dart';
part 'tables/history_offers_table.dart';
part 'tables/history_models_table.dart';

part 'daos/makes_dao.dart';
part 'daos/models_dao.dart';
part 'daos/history_offers_dao.dart';

@UseMoor(
  tables: [
    Makes,
    Models,
    HistoryOffers,
  ],
  daos: [
    MakesDao,
    ModelsDao,
    HistoryOffersDao,
  ],
)
class DatabaseProvider extends _$DatabaseProvider {
  DatabaseProvider()
      : super(
          (FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
            logStatements: true,
          )),
        );

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // Runs if the database has already been opened on the device with a lower version
        onUpgrade: (migrator, from, to) async {
          if (from == 1) {
            await migrator.createTable(historyOffers);
          }
        },
      );
}
