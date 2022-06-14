import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../home/models/filter_model.dart';
import '../../home/models/new_offer_model.dart';

class SearchRepository {
  final Dio _client;

  SearchRepository(this._client);

  Future<Either<String, SearchResult>> searchOffers(
    FilterOfferModel filter,
  ) async {
    final map = filter.toJson();

    print(map);
    var result = await _client.post(
      "/search",
      data: map,
    );

    print(result.data);
    if (result?.data["errorMessage"] != null) {
      return Left(result.data["errorMessage"]);
    }

    if (result?.data["Items"] == null) {
      return Left("Sorry, we\'re having trouble. Please try again!.");
    }

    var offers = <NewOfferModel>[];
    result.data["Items"].forEach((item) {
      var offer = NewOfferModel.fromJson(item);
      offers.add(offer);
    });

    final data = SearchResult(
        offers: offers,
        currentPage: result.data["Current-Page"],
        filter: filter,
        totalCount: result.data['Total-Hits'],
        totalPages: (result.data["Total-Pages"]).toInt() + 1);
    return Right(data);
  }
}

class SearchResult {
  int currentPage;
  int totalPages;
  List<NewOfferModel> offers;
  int totalCount;
  FilterOfferModel filter;

  SearchResult(
      {this.currentPage,
      this.offers,
      this.totalPages,
      this.totalCount,
      this.filter});
}
