import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import '../../repositories/plate_image_repository.dart';

part 'plate_by_image_cubit.freezed.dart';
part 'plate_by_image_state.dart';

class PlateByImageCubit extends Cubit<PlateByImageState> {
  final PlateImageRepository _imageRepository;
  PlateByImageCubit(this._imageRepository)
      : super(PlateByImageState.loadInitial());

  void verify({PickedFile image, bool fromCamera}) async {
    emit(PlateByImageState.loadLoading());
    final result = await _imageRepository.verify(image);

    result.fold(
      (message) => emit(PlateByImageState.loadFailure(message)),
      (file) => emit(PlateByImageState.loadSuccess(file)),
    );
  }
}
