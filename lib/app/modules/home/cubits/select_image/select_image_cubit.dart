import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/select_image_service.dart';

part 'select_image_cubit.freezed.dart';
part 'select_image_state.dart';

class SelectImageCubit extends Cubit<SelectImageState> {
  final SelectImageService _imageService;
  SelectImageCubit(this._imageService) : super(SelectImageState.loadInitial());

  void loadByCamera(BuildContext context) async {
    emit(SelectImageState.loadLoading());
    final result = await _imageService.fetchFromCamera(context);

    result.fold(
      (message) => emit(SelectImageState.loadFailure(message)),
      (file) => emit(SelectImageState.loadLoaded(file)),
    );
  }

  void loadByGallery() async {
    emit(SelectImageState.loadLoading());
    final result = await _imageService.fetchFromGallery();

    result.fold(
      (message) => emit(SelectImageState.loadFailure(message)),
      (file) => emit(SelectImageState.loadLoaded(file)),
    );
  }

  void backToInitial() {
    emit(SelectImageState.loadInitial());
  }
}
