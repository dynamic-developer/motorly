part of "recent_offers_cubit.dart";

abstract class RecentOffersState {
  const RecentOffersState();
}

class RecentOffersLoading extends RecentOffersState {
  @override
  String toString() => 'RecentOffersLoading';
}

class RecentOffersInitial extends RecentOffersState {
  @override
  String toString() => 'RecentOffersInitial';
}

class RecentOffersFailure extends RecentOffersState {
  RecentOffersFailure({
    this.error,
  }) : assert(error != null);

  final String error;
}

class RecentOffersLoaded extends RecentOffersState {
  List<NewOfferModel> data;

  RecentOffersLoaded({@required this.data});

  @override
  String toString() => 'RecentOffersLoaded {}';
}
