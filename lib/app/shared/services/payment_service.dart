import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseService extends ChangeNotifier {
  final InAppPurchase _iap = InAppPurchase.instance;
  bool available = true;
  StreamSubscription<List<PurchaseDetails>> subscription;
  static final String myProductID = "vehicle_report";

  bool _isPurchased = false;
  bool get isPurchased => _isPurchased;

  set isPurchased(bool value) {
    _isPurchased = value;
    notifyListeners();
  }

  PurchaseDetails purchase;

  List<PurchaseDetails> _purchases = [];
  List<PurchaseDetails> get purchases => _purchases;

  set purchases(List<PurchaseDetails> value) {
    _purchases = value;
    notifyListeners();
  }

  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;
  set products(List<ProductDetails> value) {
    _products = value;
    notifyListeners();
  }

  void initialize() async {
    available = await _iap.isAvailable();
    if (available) {
      await _getProducts();

      subscription = _iap.purchaseStream.listen(
        onListenPurchase,
        onDone: () {
          subscription?.cancel();
        },
        onError: (error) {},
      );

      await _iap.restorePurchases();
    }
  }

  void onListenPurchase(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        debugPrint("IAP" "Purchase is still pending!");
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        debugPrint("IAP" "An error has occurred!");
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        debugPrint("IAP" "Purchased or restored successfully!");

        await InAppPurchase.instance.completePurchase(purchaseDetails);
        purchase = purchaseDetails;
        isPurchased = true;
        debugPrint("IAP" "Purchase marked as completed");
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
        isPurchased = true;
        purchase = purchaseDetails;
        debugPrint("IAP" "Purchase marked as completed by peding");
      }
    }
    notifyListeners();
  }

  Future<void> verifyPurchase() async {
    var purchase = hasPurchased(myProductID);
    if (purchase != null && purchase.status == PurchaseStatus.purchased) {
      isPurchased = true;
    }

    debugPrint("IAP ${purchase?.status}");
    //notifyListeners();
  }

  Future<bool> buyProduct() async {
    final purchaseParam = PurchaseParam(productDetails: products.first);
    final result = await _iap.buyConsumable(purchaseParam: purchaseParam);
    return result;
  }

  PurchaseDetails hasPurchased(String productID) {
    return purchases
        .firstWhereOrNull((purchase) => purchase.productID == productID);
  }

  Future<void> _getProducts() async {
    var ids = <String>{myProductID};
    var response = await _iap.queryProductDetails(ids);
    products = response.productDetails;
  }
}
