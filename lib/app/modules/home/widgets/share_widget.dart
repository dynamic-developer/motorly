import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';
import 'package:recase/recase.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/colors.dart';
import '../cubits/loader/loader.cubut.dart';
import '../models/models.dart';
import '../models/new_offer_model.dart';

enum ShareType { offer, plate }

class ShareWidget extends StatelessWidget {
  final NewOfferModel offer;
  final MotorModel motor;
  final ShareType shareType;
  final _loaderCubit = Modular.get<LoaderCubit>();

  ShareWidget({this.offer, this.motor, @required this.shareType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: generateDynamicLink,
      child: shareType != ShareType.offer
          ? Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, left: 7),
                    child: Icon(Icons.share_outlined,
                        color: AppColors.successLight, size: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 22),
                    child: Text('Share', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            )
          : IconButton(
              icon: Icon(
                Icons.share_outlined,
                color: Colors.white,
              ),
              onPressed: generateDynamicLink),
    );
  }

  void generateDynamicLink() async {
    _loaderCubit.emit(true);
    if (shareType == ShareType.plate) {
      await createAndShareFDL(motor.plate);
    } else {
      await generateOfferDynamicLink();
    }
    _loaderCubit.emit(false);
  }

  Future<void> generateOfferDynamicLink() async {
    var _uuid = Uuid();
    var _randomOfferId = _uuid.v4();
    final _firestoreService = Modular.get<FirestoreService>();
    await _firestoreService.setDynamicLinkObject(
        offer: offer, id: _randomOfferId);
    await createAndShareFDL(_randomOfferId);
  }

  Future<void> createAndShareFDL(String id) async {
    var carDescription = '';
    var imgUrl = '';
    if (shareType == ShareType.offer) {
      carDescription =
          '${offer.carDetails.make.titleCase} ${offer.carDetails.model.titleCase} ${offer.carDetails.year}';
      imgUrl = offer.thumbnails;
    }
    if (shareType == ShareType.plate) {
      carDescription =
          '${motor.make.titleCase} ${motor.model.titleCase} ${motor.year}';
      imgUrl = "https://www.motorly.co.nz/images/images/isoPhone.png";
    }

    final plateId = shareType == ShareType.plate ? id : null;
    final offerId = shareType == ShareType.offer ? id : null;

    final params = DynamicLinkParameters(
        uriPrefix: 'https://motorly.page.link',
        link: Uri.parse(
            'https://motorly.nz/motors/?plate=$plateId&offer=$offerId'),
        androidParameters: AndroidParameters(
          packageName: 'co.nz.skadi.motorly',
        ),
        iosParameters: IosParameters(
          appStoreId: '1546978791',
          bundleId: 'co.nz.skadi.motorly',
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: "Motorly",
            description: shareType == ShareType.offer
                ? '$carDescription offer'
                : '$carDescription average price, offers and more!',
            imageUrl: Uri.parse(imgUrl)));

    final url = await params.buildShortLink();
    final shortUrl = url.shortUrl;

    if (shareType == ShareType.offer) {
      AnalyticsHelper.sharedOffer();
    } else {
      AnalyticsHelper.sharedModel();
    }

    Share.share(
        'Check out this $carDescription on Motorly: ${shortUrl.toString()}');
  }
}
