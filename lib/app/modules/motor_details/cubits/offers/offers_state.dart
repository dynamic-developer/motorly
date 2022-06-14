part of "offers_cubit.dart";

abstract class OffersState {
  const OffersState();
}

class OffersLoading extends OffersState {
  @override
  String toString() => 'OffersLoading';
}

class OffersInitial extends OffersState {
  @override
  String toString() => 'OffersInitial';
}

class OffersFailure extends OffersState {
  OffersFailure({
    this.error,
  }) : assert(error != null);

  final String error;
}

class OffersLoaded extends OffersState {
  OffersResult data;

  OffersLoaded({@required this.data});

  @override
  String toString() => 'OffersLoaded {}';
}
