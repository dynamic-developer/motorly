part of 'motor_favorites_cubit.dart';

abstract class MotorsFavoritesState {
  const MotorsFavoritesState();
}

class MotorsFavoritesLoading extends MotorsFavoritesState {
  @override
  String toString() => 'FavoritesLoading';
}

class MotorsFavoritesInitial extends MotorsFavoritesState {
  @override
  String toString() => 'FavoritesInitial';
}

class MotorsFavoritesFailure extends MotorsFavoritesState {
  MotorsFavoritesFailure({
    this.error,
  }) : assert(error != null);

  final String error;
}

class MotorsFavoritesLoaded extends MotorsFavoritesState {
  List<MotorModel> data;

  MotorsFavoritesLoaded({@required this.data});

  @override
  String toString() => 'FavoritesLoaded {}';
}
