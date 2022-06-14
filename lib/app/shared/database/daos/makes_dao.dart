part of "../database_provider.dart";

@UseDao(tables: [Makes])
class MakesDao extends DatabaseAccessor<DatabaseProvider> with _$MakesDaoMixin {
  final DatabaseProvider db;
  MakesDao(this.db) : super(db);

  //customers queries
  Future<List<Make>> get fetchAllMakes => select(makes).get();
  //fetch by id
  Future<Make> fetchMakeById(int id) {
    return (select(makes)..where((t) => t.id.equals(id))).getSingle();
  }

  //update
  Future updateMake(Make entry) {
    return update(makes).replace(entry);
  }

  //delete
  Future deleteMake(Make entry) {
    return delete(makes).delete(entry);
  }

  //create
  Future<int> addMake(Make entry) {
    return into(makes).insert(entry);
  }
}
