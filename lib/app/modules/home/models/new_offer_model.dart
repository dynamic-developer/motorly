import 'package:dartz/dartz_unsafe.dart';

class NewOfferModel {
  String source;
  int id;
  String title;
  String location;
  String subtitle;
  num price;
  CarDetails carDetails;
  String thumbnails;
  List<String> pictures;
  String link;

  NewOfferModel({
    this.source,
    this.id,
    this.title,
    this.location,
    this.subtitle,
    this.price,
    this.carDetails,
    this.thumbnails,
    this.pictures,
    this.link,
  });

  NewOfferModel.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    id = json['id'];
    title = json['title'];
    location = json['location'];
    subtitle = json['subtitle'];
    price = json['price'];
    carDetails = json['carDetails'] != null
        ? CarDetails.fromJson(json['carDetails'])
        : null;
    thumbnails = json['thumbnails'] is List ? null : json['thumbnails'];
    if (json["pictures"] != null) {
      pictures = json['pictures'].cast<String>();
    }
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['source'] = source;
    data['id'] = id;
    data['title'] = title;
    data['location'] = location;
    data['subtitle'] = subtitle;
    data['price'] = price;
    if (carDetails != null) {
      data['carDetails'] = carDetails.toJson();
    }
    data['thumbnails'] = thumbnails;
    data['pictures'] = pictures;
    data['link'] = link;
    return data;
  }
}

class CarDetails {
  String make;
  String model;
  int year;
  String subModel;
  int odometer;
  String fuel;
  String bodystyle;
  int doors;
  int engineSize;
  int seats;
  bool is4WD;
  String transmission;

  CarDetails(
      {this.make,
      this.model,
      this.year,
      this.subModel,
      this.odometer,
      this.fuel,
      this.bodystyle,
      this.doors,
      this.engineSize,
      this.seats,
      this.is4WD,
      this.transmission});

  CarDetails.fromJson(Map<String, dynamic> json) {
    make = json['make'];
    model = json['model'];
    year = json['year'];
    subModel = json['subModel'];
    odometer = json['odometer'];
    fuel = json['fuel'] == null ? "" : json['fuel'];
    bodystyle = json['bodystyle'];
    doors = json['doors'];
    engineSize = json['engineSize'];
    seats = json['seats'];
    is4WD = json['is4WD'];
    transmission = json['transmission'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['make'] = make;
    data['model'] = model;
    data['year'] = year;
    data['subModel'] = subModel;
    data['odometer'] = odometer;
    data['fuel'] = fuel;
    data['bodystyle'] = bodystyle;
    data['doors'] = doors;
    data['engineSize'] = engineSize;
    data['seats'] = seats;
    data['is4WD'] = is4WD;
    data['transmission'] = transmission;
    return data;
  }
}
