part of 'check_motor_favorite_cubit.dart';

abstract class CheckMotorFavoritesState {
  const CheckMotorFavoritesState();
}

class CheckMotorFavoritesLoading extends CheckMotorFavoritesState {
  @override
  String toString() => 'CheckMotorFavoritesLoading';
}

class CheckMotorFavoritesInitial extends CheckMotorFavoritesState {
  @override
  String toString() => 'CheckMotorFavoritesInitial';
}

class CheckMotorNoFavorite extends CheckMotorFavoritesState {}

class CheckMotorFavorite extends CheckMotorFavoritesState {}
