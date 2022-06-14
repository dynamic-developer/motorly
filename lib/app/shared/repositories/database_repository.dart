import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/home/models/models.dart';
import '../../modules/home/models/new_offer_model.dart';
import '../database/database_provider.dart';

class DatabaseRepository {
  final DatabaseProvider provider;
  DatabaseRepository(this.provider);

  Future<List<Make>> fetchAllMakes() async {
    var response = await rootBundle.loadString("assets/makes.json");
    var json = jsonDecode(response);
    List data = json["Subcategories"];
    var makes = <Make>[];

    for (var item in data) {
      print("FROM JSON $item");
      final make = Make(id: null, name: item["Name"]);
      makes.add(make);
    }
    return makes;
  }

  Future<List<Model>> fetchAllModels(String make) async {
    final dio = Dio();
    dio.options.baseUrl =
        "https://api.trademe.co.nz/v1/searchoptions.json?dependent_value=$make";
    final result = await dio.get("&key=used_car_model");

    final List data = result.data;
    var models = <Model>[];
    for (var item in data) {
      final model = Model(id: null, name: item["Value"]);
      models.add(model);
    }
    return models;
  }

  Future addHistoryOffers(NewOfferModel offer) async {
    try {
      final dataOffer = HistoryOffer(
        id: offer.id,
        offer: jsonEncode(offer.toJson()),
        createdAt: DateTime.now(),
      );
      await provider.historyOffersDao.addHistoryOffer(dataOffer);
    } on DatabaseException catch (e) {
      print(e);
    }
  }

  Future<Either<String, List<NewOfferModel>>> fetchHistoryOffers() async {
    try {
      var dataOffers = await provider.historyOffersDao.fetchAllOffers;

      dataOffers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      var offerHistory = <NewOfferModel>[];

      for (var data in dataOffers) {
        final valueMap = jsonDecode(data.offer);
        var item = NewOfferModel.fromJson(valueMap);
        offerHistory.add(item);
      }

      return Right(offerHistory);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future addHistoryModels(MotorModel motor) async {
    var _prefs = await SharedPreferences.getInstance();

    var _modelsHistory = _prefs.getStringList('modelsHistory') ?? [];
    try {
      _modelsHistory.add(json.encode(motor.toJson()));
      await _prefs.setStringList('modelsHistory', _modelsHistory);
    } on DatabaseException catch (e) {
      print(e);
    }
  }

  Future<Either<String, List<MotorModel>>> fetchHistoryModels() async {
    var _prefs = await SharedPreferences.getInstance();

    try {
      var _modelsStringList = _prefs.getStringList('modelsHistory') ?? [];
      var _modelsHistory = <MotorModel>[];

      for (var _model in _modelsStringList) {
        final valueMap = jsonDecode(_model);
        var item = MotorModel.fromJson(valueMap);
        item.createdAt = DateTime.now();
        _modelsHistory.add(item);
      }

      _modelsHistory.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      var mp = <String, MotorModel>{};
      for (var item in _modelsHistory) {
        mp[item.plate.toUpperCase()] = item;
      }
      var _filteredList = mp.values.toList();

      return Right(_filteredList);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
