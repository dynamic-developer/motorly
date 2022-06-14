part of "select_image_cubit.dart";

@freezed
abstract class SelectImageState with _$SelectImageState {
  const factory SelectImageState.loadInitial() = SelectImageInitial;
  const factory SelectImageState.loadLoading() = SelectImageLoading;
  const factory SelectImageState.loadLoaded(PickedFile item) =
      SelectImageLoaded;
  const factory SelectImageState.loadFailure(String error) = SelectImageFailure;
}
