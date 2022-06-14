part of "plate_by_image_cubit.dart";

@freezed
abstract class PlateByImageState with _$PlateByImageState {
  const factory PlateByImageState.loadInitial() = PlateByImageInitial;
  const factory PlateByImageState.loadLoading() = PlateByImageLoading;
  const factory PlateByImageState.loadSuccess(String text) = PlateByImageSuccess;
  const factory PlateByImageState.loadFailure(String error) = PlateByImageFailure;
}
