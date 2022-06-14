part of 'favorites_cubit.dart';

abstract class FavoritesState {
  const FavoritesState();
}

class FavoritesLoading extends FavoritesState {
  @override
  String toString() => 'FavoritesLoading';
}

class FavoritesInitial extends FavoritesState {
  @override
  String toString() => 'FavoritesInitial';
}

class FavoritesFailure extends FavoritesState {
  FavoritesFailure({
    this.error,
  }) : assert(error != null);

  final String error;
}

class FavoritesLoaded extends FavoritesState {
  List<NewOfferModel> data;

  FavoritesLoaded({@required this.data});

  @override
  String toString() => 'FavoritesLoaded {}';
}
