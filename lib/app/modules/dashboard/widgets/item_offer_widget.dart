import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../../home/models/new_offer_model.dart';

class ItemOfferWidget extends StatelessWidget {
  final NewOfferModel offer;
  ItemOfferWidget({@required this.offer});

  final firestoreService = Modular.get<FirestoreService>();

  final String noImage =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvgyjqsp0XQRv2gIQ-knoS20jKcTnPGiwi2bldQzdSEKTNO4lV28bZT8qrAj6XIkxy7F4&usqp=CAU";

  @override
  Widget build(BuildContext context) {
    var offerImage = noImage;
    if (offer != null && !["", null].contains(offer.thumbnails)) {
      offerImage = offer.thumbnails;
    }

    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * .40,
      child: Card(
        child: InkWell(
          onTap: () async {
            AnalyticsHelper.registerTappedOffer(offer.title);
            Navigator.of(context)
                .pushNamed("/offers/details", arguments: offer);
          },
          child: Stack(
            children: [
              Column(
                children: [
                  _buildImage(offerImage),
                  _buildDetails(offer),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(5),
                    color: AppColors.backgroundCard,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                      child: Image.asset(
                        'assets/ilustrations/trademe.png',
                        scale: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(NewOfferModel item) {
    var formatter = NumberFormat.decimalPattern("en_NZ");
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 13),
          _buildTitle(item.title),
          Divider(
            color: AppColors.lightGray,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildContent(item),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '\$${formatter.format(item.price)}',
                  style: AppTextStyles.primaryOfferPriceBold
                      .copyWith(fontSize: 12),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildContent(NewOfferModel item) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item?.carDetails?.odometer} km',
            maxLines: 2,
            style: AppTextStyles.primaryH1Light.copyWith(
              color: AppColors.lightGray,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String image) {
    return Builder(
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * .4,
        child: ClipRRect(
          borderRadius: AppDimensions.borderRadius,
          child: CachedNetworkImage(
            imageUrl: image,
            progressIndicatorBuilder: (context, child, progress) => Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            // placeholder: (context, url) => Center(
            //   child: CircularProgressIndicator(
            //     color: AppColors.primary,
            //   ),
            // ),
            errorWidget: (context, url, error) => FittedBox(
              fit: BoxFit.fitHeight,
              child: Icon(
                Icons.image_not_supported_rounded,
                color: AppColors.danger,
              ),
            ),
            fit: BoxFit.cover,
          ),
          // child: Image.network(
          //   "$image",
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Builder(
      builder: (context) => Text(
        '$title',
        maxLines: 1,
        style: AppTextStyles.primaryBold.copyWith(
          color: Theme.of(context).canvasColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
