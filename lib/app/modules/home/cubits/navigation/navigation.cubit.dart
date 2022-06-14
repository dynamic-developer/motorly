import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void updateIndex(int index) {
    emit(index);
  }

  void getHome() => emit(0);
  void getScanner() => emit(1);
  void getWishlist() => emit(2);
  void getProfile() => emit(3);
}
