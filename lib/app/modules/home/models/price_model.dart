class PriceModel {
  String year;
  Stats stats;

  PriceModel({this.year, this.stats});

  PriceModel.fromJson(Map<String, dynamic> json) {
    stats = Stats.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['year'] = year;
    if (stats != null) {
      data['stats'] = stats.toJson();
    }
    return data;
  }
}

class Stats {
  int count;
  int average;
  int min;
  int max;

  Stats({this.count, this.average, this.min, this.max});

  Stats.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    average = json['average'];
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = count;
    data['average'] = average;
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}
