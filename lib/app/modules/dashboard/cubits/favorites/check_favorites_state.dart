part of 'check_favorite_cubit.dart';

abstract class CheckFavoritesState {
  const CheckFavoritesState();
}

class CheckFavoritesLoading extends CheckFavoritesState {
  @override
  String toString() => 'CheckFavoritesLoading';
}

class CheckFavoritesInitial extends CheckFavoritesState {
  @override
  String toString() => 'CheckFavoritesInitial';
}

class CheckFavoritesFailure extends CheckFavoritesState {
  CheckFavoritesFailure({
    this.error,
  }) : assert(error != null);

  final String error;
}

class CheckFavoritesLoaded extends CheckFavoritesState {
  bool data;

  CheckFavoritesLoaded({@required this.data});

  @override
  String toString() => 'CheckFavoritesLoaded {}';
}
