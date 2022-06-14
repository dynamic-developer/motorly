part of "../database_provider.dart";

@UseDao(tables: [HistoryOffers])
class HistoryOffersDao extends DatabaseAccessor<DatabaseProvider>
    with _$HistoryOffersDaoMixin {
  final DatabaseProvider db;
  HistoryOffersDao(this.db) : super(db);

  //customers queries
  Future<List<HistoryOffer>> get fetchAllOffers => select(historyOffers).get();
  //fetch by id
  Future<HistoryOffer> fetchHistoryOfferById(int id) {
    return (select(historyOffers)..where((t) => t.id.equals(id))).getSingle();
  }

  //update
  Future updateHistoryOffer(HistoryOffer entry) {
    return update(historyOffers).replace(entry);
  }

  //delete
  Future deleteHistoryOffer(HistoryOffer entry) {
    return delete(historyOffers).delete(entry);
  }

  //create
  Future<int> addHistoryOffer(HistoryOffer entry) {
    return into(historyOffers).insert(entry);
  }
}
