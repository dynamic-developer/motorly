import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/modules/dashboard/cubits/recent_models/recent_models_cubit.dart';

import '../../../shared/repositories/database_repository.dart';
import '../../home/models/filter_model.dart';
import '../../home/models/new_offer_model.dart';
import '../../home/models/old_motor_model.dart';
import '../../home/models/price_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class MotorsRepository {
  final Dio _client;
  final DatabaseRepository _databaseRepository;

  MotorsRepository(this._client, this._databaseRepository);

//get motors
  Future<Either<String, MotorModel>> fetchByPlate(String plate) async {
    final _recentModelsCubit = Modular.get<RecentModelsCubit>();

    try {
      plate = plate.replaceAll(RegExp(' '), '');
      //print(plate);
      if (plate != null) {
        if (plate.length > 6) {
          return Left(
              "Sorry, the maximum plate length is 6 characters. Please try again.");
        } else if (!RegExp(r"^[a-zA-Z0-9 ]+$").hasMatch(plate)) {
          return Left(
              "Sorry, please insert a valid plate without special characters and try again!");
        }
        print(plate);
        final result = await _client.post("/plate", data: {
          "plate": plate,
        }).timeout(const Duration(seconds: 30));
        if (result.data == null) {
          return Left(
              "Sorry we couldn\'t identify that car. Check the plate number and try again!");
        }
        print(result.data);
        var motor = MotorModel.fromJson(result?.data);
        print(motor.plate);

        if (motor.plate != null) {
          motor.makes = await _databaseRepository.fetchAllMakes();
          motor.models = await _databaseRepository.fetchAllModels(motor.make);

          motor.price = await fetchPrices(motor);
          await _databaseRepository.addHistoryModels(motor);
          _recentModelsCubit.load();
          return Right(motor);
        } else {
          print('error');
          return Left(
              "Sorry, we\'re having trouble finding that car. Please try again!");
        }
      } else {
        print('error');

        return Left(
            "Sorry we couldn\'t identify that car. Check the plate number and try again!");
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      print(error);
      FirebaseCrashlytics.instance
          .log("Error while trying to scan a car, plate: $plate");
      FirebaseCrashlytics.instance.recordError(error, StackTrace.current);

      return Left("Sorry we couldn\'t identify that car. Try again!");
    }
  }

//get offers
  Future<Either<String, OffersResult>> fetchOffers(
    FilterOfferModel filter,
  ) async {
    var _isSimilar = false;

    final map = filter.toJson();
    var result = await _client.post(
      "/search",
      data: map,
    );

    print('offers');
    print(map);

    print(result.data);

    if (result?.data["errorMessage"] != null) {
      return Left(result.data["errorMessage"]);
    }

    if (result?.data["Items"] == null ||
        result?.data["Items"].toString() == '[]' && filter.fetchSimilar) {
      _isSimilar = true;
      result = await _client.post(
        "/similar",
        data: map,
      );
      print(result.data);
      if (result?.data["Items"] == null) {
        return Left("No published offers.");
      }
    }

    var offers = <NewOfferModel>[];
    result.data["Items"].forEach((item) {
      var offer = NewOfferModel.fromJson(item);
      offers.add(offer);
    });

    final data = OffersResult(
        offers: offers,
        currentPage: result.data["Current-Page"],
        totalCount: result.data['Total-Hits'],
        totalPages: (result.data["Total-Pages"]).toInt() + 1,
        isSimilar: _isSimilar);
    return Right(data);
  }

  Future<List<NewOfferModel>> getSimilar(Map map) async {
    var result = await _client.post(
      "/similar",
      data: map,
    );
    print(result.data);

    var offers = <NewOfferModel>[];
    result.data["Items"].forEach((item) {
      var offer = NewOfferModel.fromJson(item);
      offers.add(offer);
    });

    return offers;
  }

//get prices
  Future<PriceModel> fetchPrices(MotorModel motor) async {
    final dio = Dio();
    dio.options.baseUrl = "https://api.motorlytics.co.nz";

    var engineSizeDouble =
        motor.engineSize != null ? double.parse(motor.engineSize) : 1;

    var request = {
      "make": motor.make,
      "model": motor.model,
      "year": motor.year,
      "engineSize": engineSizeDouble > 1 ? engineSizeDouble : "",
      "bodyType": motor.bodyType
    };

    final result = await dio.post("/prices", data: request);

    try {
      return PriceModel.fromJson(result.data);
    }
    // ignore: avoid_catches_without_on_clauses
    catch (error) {
      FirebaseCrashlytics.instance
          .log("Error while trying to fetch prices, plate:${motor.plate}");

      if (result.data != null) {
        FirebaseCrashlytics.instance.log("Result Data: ${result.data}");
      }

      FirebaseCrashlytics.instance.recordError(error, StackTrace.current);
      return null;
    }
  }
}

class OffersResult {
  int currentPage;
  bool isSimilar;
  int totalPages;
  List<NewOfferModel> offers;
  int totalCount;

  OffersResult({
    this.currentPage,
    this.offers,
    this.totalPages,
    this.isSimilar,
    this.totalCount,
  });
}
