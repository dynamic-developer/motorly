class OfferModel {
  int year;
  String make;
  String model;
  int price;
  String location;
  String title;
  String thumbnail;
  String link;
  int id;
  String source;

  OfferModel({
    this.year,
    this.make,
    this.model,
    this.price,
    this.location,
    this.title,
    this.thumbnail,
    this.link,
    this.id,
    this.source,
  });

  OfferModel.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    make = json['make'];
    model = json['model'];
    price = json['price'];
    location = json['location'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    link = json['link'];
    id = json["id"];
    source = json["source"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['year'] = year;
    data['make'] = make;
    data['model'] = model;
    data['price'] = price;
    data['location'] = location;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['link'] = link;
    data['id'] = id;
    data['source'] = source;
    return data;
  }
}
