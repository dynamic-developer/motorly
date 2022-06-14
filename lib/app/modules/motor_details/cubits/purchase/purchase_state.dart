part of 'purchase_cubit.dart';

abstract class PurchaseState {
  const PurchaseState();
}

class PurchaseLoading extends PurchaseState {
  @override
  String toString() => 'PurchaseLoading';
}

class PurchaseLoadingBuy extends PurchaseState {
  @override
  String toString() => 'PurchaseLoading';
}

class PurchaseInitial extends PurchaseState {
  @override
  String toString() => 'PurchaseInitial';
}

class PurchaseFailure extends PurchaseState {
  PurchaseFailure({
    this.error,
  }) : assert(error != null);

  final String error;
}

class PurchaseSuccess extends PurchaseState {
  final String link;
  PurchaseSuccess(this.link);
  @override
  String toString() => 'PurchaseLoaded {}';
}
