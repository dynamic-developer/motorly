import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../constants/dynamic_link_constants.dart';
import '../models/dynamic_link_model.dart';
import '../utils/dynamic_link_helper.dart';

class DynamicLinkService {
  final String _refCodeKey = plateRefCodeConstant;
  final String _refOfferKey = offerRefCodeConstant;

  Future<void> initDynamicLinks() async {
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final _deepLink = data?.link;

    print('link data 1: ${_deepLink}');
    if (_deepLink != null) {
      await loadDynamicLinks(data);
    }

    FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) async {
      final _deepLink = dynamicLink?.link;
      print('link data 2: ${_deepLink}');

      if (_deepLink != null) {
        await loadDynamicLinks(dynamicLink);
      }
    }, onError: (e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  String getPlateCodeFromUri(Uri uri) {
    final _refCode = uri.queryParameters[_refCodeKey];
    return _refCode;
  }

  String getOfferCodeFromUri(Uri uri) {
    final _refOffer = uri.queryParameters[_refOfferKey];
    return _refOffer;
  }

  Future<void> loadDynamicLinks(PendingDynamicLinkData dynamicLink) async {
    final _deepLink = dynamicLink?.link;

    var _offerCode = getOfferCodeFromUri(_deepLink) ?? 'null';
    var _plateCode = getPlateCodeFromUri(_deepLink) ?? 'null';

    await handleDynamicLink(_offerCode, _plateCode);
  }

  Future<void> handleDynamicLink(String offerCode, String plateCode) async {
    if (offerCode != 'null' || plateCode != 'null') {
      var _dynamicLinkObject = DynamicLinkModel(plate: plateCode, offer: offerCode);
      await _dynamicLinkHelper(_dynamicLinkObject);
    }
  }

  Future<void> _dynamicLinkHelper(DynamicLinkModel dynamicLinkObject) async {
    DynamicLinkHelper.appDynamicLinkHelper.showDynamicLinkHelper(dynamicLinkObject);
  }
}
