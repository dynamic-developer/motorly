class FilterOfferModel {
  String keywords;
  int year;
  int yearMax;
  String make;
  String model;
  String type;
  String location;
  String price;
  String priceMax;
  String sortOrder;
  String odometer;
  String odometerMax;
  int page;
  int pageSize;
  bool fetchSimilar = true;

  FilterOfferModel({
    this.keywords,
    this.year,
    this.make,
    this.yearMax,
    this.model,
    this.type,
    this.location,
    this.sortOrder,
    this.price,
    this.priceMax,
    this.odometer,
    this.odometerMax,
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (make != null && make != "Any") {
      data['make'] = make;
    }
    if (year != null) {
      data['year'] = year;
    }

    if (sortOrder != null && sortOrder != "Any") {
      data['poySort'] = sortOrder;
    }

    if (yearMax != null) {
      data['yearMax'] = yearMax;
    }

    if (keywords != null) {
      data['keywords'] = keywords;
    }

    if (model != null && model != "Any") {
      data['model'] = model;
    }
    if (type != null && type != "Any") {
      data['type'] = type;
    }
    if (location != null && location != "New Zealand") {
      data['location'] = location;
    }
    if (price != null && price != "Any") {
      data['price'] = int.parse(price);
    }
    if (priceMax != null && priceMax != "Any") {
      data['priceMax'] = int.parse(priceMax);
    }
    if (odometer != null && odometer != "Any") {
      data['odometer'] = int.parse(odometer);
    }
    if (odometerMax != null && odometerMax != "Any") {
      data['odometerMax'] = int.parse(odometerMax);
    }
    if (page != null) {
      data['page'] = page;
    }
    if (pageSize != null) {
      data['pageSize'] = pageSize;
    }
    return data;
  }
}
