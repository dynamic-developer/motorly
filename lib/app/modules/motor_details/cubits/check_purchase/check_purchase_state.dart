part of 'check_purchase_cubit.dart';

abstract class CheckPurchaseState {
  const CheckPurchaseState();
}

class CheckPurchaseLoading extends CheckPurchaseState {
  @override
  String toString() => 'CheckPurchaseLoading';
}

class CheckPurchaseInitial extends CheckPurchaseState {
  @override
  String toString() => 'CheckPurchaseInitial';
}

class CheckNoPurchase extends CheckPurchaseState {}

class CheckPurchased extends CheckPurchaseState {}
