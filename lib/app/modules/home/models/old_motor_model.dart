//import 'package:freezed_annotation/freezed_annotation.dart';
//part 'motor_model.g.dart';

import '../../../shared/database/database_provider.dart';
import 'models.dart';
import 'new_offer_model.dart';
//@JsonSerializable(nullable: false)

class MotorModel {
  String plate;
  String make;
  String model;
  String subModel;
  String transmission;
  DateTime createdAt;

  String bodyType;
  int year;
  String engineSize;
  String seats;
  String fuelType;
  PriceModel price;
  List<NewOfferModel> offers;
  List<Make> makes;
  List<Model> models;
  bool is4WD;

  MotorModel(
      {this.plate,
      this.make,
      this.model,
      this.createdAt,
      this.subModel,
      this.seats,
      this.bodyType,
      this.year,
      this.engineSize,
      this.fuelType,
      this.price,
      this.transmission});

  MotorModel.fromJson(Map<String, dynamic> json) {
    plate = checkNullString(json['plate']);
    make = checkNullString(json['make']);
    seats = checkNullString(json['seats'].toString());
    model = checkNullString(json['model']);
    subModel = checkNullString(json['subModel']);
    bodyType = checkNullString(json['bodyType']);
    year = int.parse(checkNullString(json['year'].toString()));
    engineSize = checkNullString(json['engineSize'].toString());
    fuelType = checkNullString(json['fuelType']);
    transmission = json['transmission'] == "CVT" ? "Automatic" : "Manual";
    is4WD = json['drive'] == "4WD" ? true : false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['plate'] = plate;
    data['make'] = make;
    data['model'] = model;
    data['seats'] = seats;
    data['subModel'] = subModel;
    data['bodyType'] = bodyType;
    data['year'] = year;
    data['engineSize'] = engineSize;
    data['fuelType'] = fuelType;
    data['transmission'] = transmission;
    return data;
  }

  String checkNullString(String value) {
    return value == "null" || value == "" ? null : value.toString();
  }
}
