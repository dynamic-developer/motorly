import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderCubit extends Cubit<bool> {
  LoaderCubit() : super(false);

  void updateIndex(bool isLoading) {
    emit(isLoading);
  }
}
