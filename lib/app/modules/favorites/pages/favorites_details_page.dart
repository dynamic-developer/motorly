import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../../../shared/widgets/custom_app_bar_widget.dart';
import '../../../shared/widgets/custom_button_widget.dart';
import '../../home/models/new_offer_model.dart';

class FavoritesDetailedPage extends StatefulWidget {
  final NewOfferModel offer;

  FavoritesDetailedPage({@required this.offer});
  @override
  _FavoritesDetailedPageState createState() => _FavoritesDetailedPageState();
}

class _FavoritesDetailedPageState extends State<FavoritesDetailedPage> {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    //var _formatter = NumberFormat.decimalPattern("en_NZ");

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: _buildImage(
                  widget.offer?.thumbnails ??
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvgyjqsp0XQRv2gIQ-knoS20jKcTnPGiwi2bldQzdSEKTNO4lV28bZT8qrAj6XIkxy7F4&usqp=CAU",
                ),
              ),
              Padding(
                padding: AppDimensions.marginScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 13),
                    _buildTitle(widget.offer.title),
                    SizedBox(height: 5),
                    Divider(color: Colors.white),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildContent(widget.offer),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomButtonWidget(
                      text: "See Offer  (Trade Me)",
                      onTap: () => {
                        AnalyticsHelper.tappedSeeOfferOnTrademeFromFav(
                            widget.offer.title),
                        _launchInBrowser(widget.offer.link)
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomAppBarWidget(),
        ],
      ),
    );
  }

  Widget _buildContent(NewOfferModel item) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            '${item?.location}',
            maxLines: 2,
            style: AppTextStyles.primaryH1Light.copyWith(
              color: AppColors.lightGray,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${item?.carDetails?.year}',
            maxLines: 2,
            style: AppTextStyles.primaryH1Light.copyWith(
              color: AppColors.lightGray,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${item?.carDetails?.make}',
            maxLines: 2,
            style: AppTextStyles.primaryH1Light.copyWith(
              color: AppColors.lightGray,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String image) {
    return ClipRRect(
      borderRadius: AppDimensions.borderRadius,
      child: CachedNetworkImage(
        imageUrl: image,
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
        // placeholder: (context, url) => Center(
        //   child: CircularProgressIndicator(
        //     color: AppColors.primary,
        //   ),
        // ),
        errorWidget: (context, url, error) => Icon(
          Icons.image_not_supported_rounded,
          color: AppColors.danger,
          size: 100,
        ),
        fit: BoxFit.fitHeight,
      ),
      // child: Image.network(
      //   "$image",
      //   fit: BoxFit.fitHeight,
      // ),
    );
  }

  Widget _buildTitle(String title) {
    return Builder(
      builder: (context) => Text(
        '$title',
        maxLines: 2,
        style: AppTextStyles.primaryH1Regular.copyWith(
          color: Theme.of(context).canvasColor,
          fontSize: 24,
        ),
      ),
    );
  }
}
