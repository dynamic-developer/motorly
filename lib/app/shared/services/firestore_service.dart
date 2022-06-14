import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motorly/app/shared/models/motor_report_model.dart';

import '../../modules/home/models/models.dart';
import '../../modules/home/models/new_offer_model.dart';

class FirestoreService {
  final databaseInstance = FirebaseFirestore.instance;
  final authInstance = FirebaseAuth.instance;

  void addSearchOffers({NewOfferModel offer}) async {
    if (authInstance.currentUser != null) {
      final reference = databaseInstance.collection("recent-search");
      try {
        await reference
            .doc(authInstance.currentUser.uid)
            .collection("offers")
            .doc("${offer?.id}")
            .set(offer.toJson());
      } on Exception catch (e) {
        print("Failed to add info: $e");
      }
    }
  }

  void setDynamicLinkObject({NewOfferModel offer, String id}) async {
    final reference = databaseInstance.collection("dynamic-link");
    try {
      await reference.doc(id).set(offer.toJson());
    } on Exception catch (e) {
      print("Failed to add info: $e");
    }
  }

  Future<NewOfferModel> getDynamicLinkObject({String id}) async {
    var _offer = NewOfferModel();
    final reference = databaseInstance.collection("dynamic-link");
    try {
      var _doc = await reference.doc(id).get();
      _offer = NewOfferModel.fromJson(_doc.data());
    } on Exception catch (e) {
      print("Failed to add info: $e");
    }
    return _offer;
  }

  Future<Either<String, List<NewOfferModel>>> getSearchOffers() async {
    final reference = databaseInstance.collection("recent-search");

    if (authInstance.currentUser == null) {
      return Left("");
    }

    try {
      final snapshot = await reference
          .doc(authInstance.currentUser.uid)
          .collection("offers")
          .get();

      var offers = <NewOfferModel>[];

      for (var doc in snapshot.docs) {
        var offer = NewOfferModel.fromJson(doc.data());
        offers.add(offer);
      }

      return Right(offers);
    } on Exception catch (e) {
      print("Failed to get info: $e");
      return Left("Failed to get info");
    }
  }

  Future<String> addFavorites({NewOfferModel offer}) async {
    var _text;

    var _offer = offer.toJson();
    _offer['createdAt'] = FieldValue.serverTimestamp();

    if (authInstance.currentUser != null) {
      var _isFavorite = await checkFavorites(offer: offer);
      if (!_isFavorite) {
        final reference = databaseInstance.collection("favorites");
        try {
          await reference
              .doc(authInstance.currentUser.uid)
              .collection("offers")
              .doc("${offer?.id}")
              .set(_offer);
          _text = 'Added to Wishlist';
        } on Exception catch (e) {
          print(e);
          _text = 'Failed to add into Wishlist';
        }
      } else {
        _text = await removeFavorites(offer: offer);
      }
    }
    return _text;
  }

  Future<String> removeFavorites({NewOfferModel offer}) async {
    var _text;
    if (authInstance.currentUser != null) {
      var _isFavorite = await checkFavorites(offer: offer);

      if (_isFavorite) {
        final reference = databaseInstance.collection("favorites");
        try {
          await reference
              .doc(authInstance.currentUser.uid)
              .collection("offers")
              .doc("${offer?.id}")
              .delete();
          _text = 'Removed from Wishlist';
        } on Exception catch (e) {
          print("Failed to add info: $e");
          _text = 'Failed to remove from Wishlist';
        }
      } else {
        _text = await addFavorites(offer: offer);
      }
    }
    return _text;
  }

  Future<bool> checkFavorites({NewOfferModel offer}) async {
    var _isFavorite;

    if (authInstance.currentUser != null) {
      final reference = databaseInstance.collection("favorites");
      try {
        await reference
            .doc(authInstance.currentUser.uid)
            .collection("offers")
            .doc("${offer?.id}")
            .get()
            .then((value) => _isFavorite = value.exists);
      } on Exception catch (e) {
        print("Failed to check info: $e");
      }
    }
    return _isFavorite;
  }

  Future<Either<String, List<NewOfferModel>>> getFavorites() async {
    final reference = databaseInstance.collection("favorites");

    if (authInstance.currentUser == null) {
      return Left("");
    }

    try {
      final snapshot = await reference
          .doc(authInstance.currentUser.uid)
          .collection("offers")
          .orderBy('createdAt', descending: true)
          .get();

      var offers = <NewOfferModel>[];

      for (var doc in snapshot.docs) {
        var offer = NewOfferModel.fromJson(doc.data());
        offers.add(offer);
      }

      return Right(offers);
    } on Exception catch (e) {
      print("Failed to get info: $e");
      return Left("Failed to get info");
    }
  }

  Future<String> addFavoritesMotor({MotorModel motor}) async {
    var _motor = motor.toJson();
    _motor['createdAt'] = FieldValue.serverTimestamp();

    var _text;
    if (authInstance.currentUser != null) {
      var _isFavorite = await checkFavoritesMotor(motor: motor);
      if (!_isFavorite) {
        final reference = databaseInstance.collection("favorites");

        try {
          await reference
              .doc(authInstance.currentUser.uid)
              .collection("motors")
              .doc("${motor?.plate}")
              .set(_motor);
          _text = 'Added to Wishlist';
        } on Exception catch (e) {
          print(e);
          _text = 'Failed to remove from Wishlist';
        }
      } else {
        _text = removeFavoritesMotor(motor: motor);
      }
    }
    return _text;
  }

  Future<String> removeFavoritesMotor({MotorModel motor}) async {
    var _text;
    if (authInstance.currentUser != null) {
      var _isFavorite = await checkFavoritesMotor(motor: motor);
      if (_isFavorite) {
        final reference = databaseInstance.collection("favorites");
        try {
          await reference
              .doc(authInstance.currentUser.uid)
              .collection("motors")
              .doc("${motor?.plate}")
              .delete();
          _text = 'Removed from Wishlist';
        } on Exception catch (e) {
          print(e);

          _text = 'Failed to remove from Wishlist';
        }
      } else {
        _text = addFavoritesMotor(motor: motor);
      }
    }
    return _text;
  }

  Future<bool> checkFavoritesMotor({MotorModel motor}) async {
    if (authInstance.currentUser != null) {
      final reference = databaseInstance.collection("favorites");
      try {
        final result = await reference
            .doc(authInstance.currentUser.uid)
            .collection("motors")
            .doc("${motor?.plate}")
            .get();
        return result.exists;
      } on Exception catch (e) {
        print("Failed to check info: $e");
      }
    }
    return false;
  }

  Future<Either<String, MotorReportModel>> addReportPurchase(
      {MotorReportModel report}) async {
    if (authInstance.currentUser != null) {
      final reference = databaseInstance.collection("report-purchases");
      try {
        final ref = await reference.add({
          "userId": report.userId,
          "purchaseId": report.plateNumber,
          "plateNumber": report.plateNumber,
          "purchaseDate": DateTime.now(),
          "paymentMethod": report.paymentMethod,
          "make": report.make,
          "model": report.model,
          "year": report.year,
          "subModel": report.subModel
        });

        report.reportId = ref.id;
        return Right(report);
      } on Exception catch (e) {
        print("Failed to add info: $e");
        return Left("Failed to record the purchase");
      }
    }
    return Left("User not authenticated");
  }

  Future<bool> checkPurchase({String reportId}) async {
    if (authInstance.currentUser != null) {
      final reference = databaseInstance.collection("purchases");
      try {
        final result = await reference.doc(reportId).get();
        return result.exists;
      } on Exception catch (e) {
        print("Failed to check info: $e");
      }
    }
    return false;
  }

  Future<Either<String, List<MotorModel>>> getFavoritesMotors() async {
    final reference = databaseInstance.collection("favorites");

    if (authInstance.currentUser == null) {
      return Left("");
    }

    try {
      final snapshot = await reference
          .doc(authInstance.currentUser.uid)
          .collection("motors")
          .orderBy('createdAt', descending: true)
          .get();

      var motors = <MotorModel>[];

      for (var doc in snapshot.docs) {
        var motor = MotorModel.fromJson(doc.data());
        motors.add(motor);
      }

      return Right(motors);
    } on Exception catch (e) {
      print("Failed to get info: $e");
      return Left("Failed to get info");
    }
  }
}
