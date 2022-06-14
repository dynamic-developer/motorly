part of "../database_provider.dart";

@UseDao(tables: [Models])
class ModelsDao extends DatabaseAccessor<DatabaseProvider>
    with _$ModelsDaoMixin {
  final DatabaseProvider db;
  ModelsDao(this.db) : super(db);

  //customers queries
  Future<List<Model>> get fetchAllModels => select(models).get();
  //fetch by id
  Future<Model> fetchModelById(int id) {
    return (select(models)..where((t) => t.id.equals(id))).getSingle();
  }

  //update
  Future updateModel(Model entry) {
    return update(models).replace(entry);
  }

  //delete
  Future deleteModel(Model entry) {
    return delete(models).delete(entry);
  }

  //create
  Future<int> addModel(Model entry) {
    return into(models).insert(entry);
  }
}
