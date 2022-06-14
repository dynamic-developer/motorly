part of 'recent_models_cubit.dart';

abstract class RecentModelsState {
  const RecentModelsState();
}

class RecentModelsLoading extends RecentModelsState {
  @override
  String toString() => 'RecentModelsLoading';
}

class RecentModelsInitial extends RecentModelsState {
  @override
  String toString() => 'RecentModelsInitial';
}

class RecentModelsFailure extends RecentModelsState {
  RecentModelsFailure({
    this.error,
  }) : assert(error != null);

  final String error;
}

class RecentModelsLoaded extends RecentModelsState {
  List<MotorModel> data;

  RecentModelsLoaded({@required this.data});

  @override
  String toString() => 'RecentModelsLoaded {}';
}
