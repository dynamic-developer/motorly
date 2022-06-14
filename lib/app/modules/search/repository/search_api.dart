import 'package:dio/dio.dart';
import 'package:motorly/app/modules/home/models/filter_model.dart';
import 'package:motorly/app/modules/home/models/new_offer_model.dart';

class SearchAPI {
  Dio _dio = Dio();

  Future<List<NewOfferModel>> getPageData(
      int page, FilterOfferModel filterOfferModel) async {
    filterOfferModel.page = page;

    final result = await Dio().post("https://api.motorlytics.co.nz/search",
        data: filterOfferModel.toJson());

    var offers = <NewOfferModel>[];
    await Future.forEach(result.data["Items"], (item) {
      var offer = NewOfferModel.fromJson(item);
      offers.add(offer);
    });
    return offers;
  }
}
