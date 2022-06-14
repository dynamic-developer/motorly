import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../shared/repositories/database_repository.dart';
import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../../authentication/authentication_page.dart';
import '../../dashboard/cubits/favorites/check_favorite_cubit.dart';
import '../../dashboard/cubits/recent_offers/recent_offers_cubit.dart';
import '../models/new_offer_model.dart';

class ItemOfferWidget extends StatefulWidget {
  final NewOfferModel offer;

  ItemOfferWidget({@required this.offer, Key key}) : super(key: key);

  @override
  _ItemOfferWidgetState createState() => _ItemOfferWidgetState();
}

class _ItemOfferWidgetState extends State<ItemOfferWidget> {
  bool _isVisible;

  final firestoreService = Modular.get<FirestoreService>();

  final authInstance = FirebaseAuth.instance;

  final databaseRepository = Modular.get<DatabaseRepository>();

  final rececentOffersCubit = Modular.get<RecentOffersCubit>();

  final _checkFavoritesCubit = Modular.get<CheckFavoritesCubit>();

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() async {
    _isVisible = await _checkFavoritesCubit.load(widget.offer);
  }

  @override
  Widget build(BuildContext context) {
    var _isFavoritesPage = ModalRoute.of(context).settings.name == "/favorites";

    return BlocBuilder<CheckFavoritesCubit, CheckFavoritesState>(
        bloc: _checkFavoritesCubit,
        builder: (context, state) {
          void showButton(offer) async {
            if (authInstance.currentUser != null) {
              _isVisible = await _checkFavoritesCubit.load(offer);
              if (state is CheckFavoritesLoaded) {
                if (_isVisible == false) {
                  var _text = await firestoreService.addFavorites(offer: offer);
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();

                  ScaffoldMessenger.of(context)
                      .showSnackBar(_favoritesSnackBar(_text));
                } else {
                  var _text =
                      await firestoreService.removeFavorites(offer: offer);

                  ScaffoldMessenger.of(context).removeCurrentSnackBar();

                  ScaffoldMessenger.of(context)
                      .showSnackBar(_favoritesSnackBar(_text));
                }
              }
              setState(() {
                _isVisible = !_isVisible;
              });
            }
          }

          return Card(
            child: InkWell(
              onTap: () async {
                databaseRepository.addHistoryOffers(widget.offer);
                rececentOffersCubit.load();
                AnalyticsHelper.registerTappedOffer(widget.offer.title);
                if (_isFavoritesPage) {
                  AnalyticsHelper.tappedWishListOfferItem();
                }
                Navigator.of(context).pushNamed(
                  "/offers/details",
                  arguments: widget.offer,
                );
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      Stack(children: [
                        _buildImage(
                            !["", null, "null"]
                                    .contains(widget.offer.thumbnails)
                                ? widget.offer.thumbnails
                                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvgyjqsp0XQRv2gIQ-knoS20jKcTnPGiwi2bldQzdSEKTNO4lV28bZT8qrAj6XIkxy7F4&usqp=CAU",
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height * 0.25),
                        Positioned(
                            right: 10,
                            bottom: 10,
                            child: Visibility(
                                visible: _isFavoritesPage
                                    ? _isVisible ?? true
                                    : _isVisible ?? false,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  child: state is CheckFavoritesLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : FloatingActionButton(
                                          heroTag: widget.offer,
                                          backgroundColor:
                                              Color.fromRGBO(193, 12, 69, 1),
                                          child: Visibility(
                                              child: state
                                                      is CheckFavoritesLoading
                                                  ? CircularProgressIndicator(
                                                      color: Colors.white,
                                                    )
                                                  : Icon(Icons.favorite,
                                                      color: Colors.white)),
                                          onPressed:
                                              () /*=> setState(() */ async {
                                            if (authInstance.currentUser !=
                                                null) {
                                              await showButton(widget.offer);
                                            } else {
                                              Navigator.of(context).push(
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (context) =>
                                                          AuthenticationPage(
                                                              isOriginHome:
                                                                  false,
                                                              callBack:
                                                                  () async => {
                                                                        await showButton(
                                                                            widget.offer)
                                                                      }),
                                                ),
                                              );
                                            }
                                          }),
                                ),
                                replacement: Container(
                                  width: 36,
                                  height: 36,
                                  child: state is CheckFavoritesLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : FloatingActionButton(
                                          heroTag: widget.offer,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.6),
                                          child: state is CheckFavoritesLoading
                                              ? CircularProgressIndicator(
                                                  color: Colors.white)
                                              : Icon(Icons.favorite_border,
                                                  color: Colors.white),
                                          onPressed:
                                              () /*=> setState(() */ async {
                                            if (authInstance.currentUser !=
                                                null) {
                                              await showButton(widget.offer);
                                            } else {
                                              Navigator.of(context).push(
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (context) =>
                                                          AuthenticationPage(
                                                              isOriginHome:
                                                                  false,
                                                              callBack:
                                                                  () async => {
                                                                        await showButton(
                                                                            widget.offer)
                                                                      }),
                                                ),
                                              );
                                            }
                                          }),
                                ))),
                      ]),
                      _buildDetails(widget.offer),
                    ],
                  ),
                  _buildPrice(widget.offer.price),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(5),
                        color: AppColors.backgroundCard,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: 30,
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
          );
        });
  }

  Widget _buildDetails(NewOfferModel item) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 13,
          ),
          _buildTitle(item.title),
          Divider(
            color: AppColors.lightGray,
            height: 13,
          ),
          _buildContent(item),
          SizedBox(
            height: 13,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(NewOfferModel item) {
    var formatter = NumberFormat.decimalPattern("en_NZ");
    var engineSizeLabel = item?.carDetails?.engineSize == 0
        ? ""
        : ' - ${formatter.format(item?.carDetails?.engineSize)} cc';

    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            '${item?.carDetails?.make} ${item?.carDetails?.model} ${item?.carDetails?.year} - ${formatter.format(item?.carDetails?.odometer)} km',
            maxLines: 2,
            style: AppTextStyles.primaryH1Light.copyWith(
              color: AppColors.lightGray,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '${item?.carDetails?.fuel} - ${item?.carDetails?.transmission} $engineSizeLabel',
            maxLines: 2,
            style: AppTextStyles.primaryH1Light.copyWith(
              color: AppColors.lightGray,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '${item?.location}',
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

  Widget _buildPrice(num price) {
    var formatter = NumberFormat.decimalPattern("en_NZ");
    return Positioned(
      bottom: 15,
      right: 15,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          '\$${formatter.format(price)}',
          style: AppTextStyles.primaryOfferPriceBold,
        ),
      ),
    );
  }

  Widget _buildImage(String image, width, height) {
    return Container(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: AppDimensions.borderRadius,
        child: Image.network(
          image,

          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }, // placeholder: (context, url) => Center(
          //   child: CircularProgressIndicator(
          //     color: AppColors.primary,
          //   ),
          // ),
          errorBuilder: (context, url, error) => Icon(
            Icons.image_not_supported_rounded,
            color: AppColors.danger,
            size: 100,
          ),
          fit: BoxFit.cover,
        ),
        // child: Image.network(
        //   "$image",
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Builder(
      builder: (context) => Text(
        '$title',
        maxLines: 2,
        style: AppTextStyles.primaryH1Regular.copyWith(
          color: Theme.of(context).canvasColor,
          fontSize: 16,
        ),
      ),
    );
  }

  SnackBar _favoritesSnackBar(String message) {
    var _firstClick = true;
    return SnackBar(
      backgroundColor: Color.fromRGBO(32, 32, 36, 1),
      content: InkWell(
        onTap: () => {
          if (_firstClick == true)
            Navigator.of(context).pushNamed("/favorites"),
          _firstClick = false,
        },
        child: Container(
          height: 50,
          child: Row(
            children: [
              Text(
                message,
                style: AppTextStyles.primaryBold.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                "View all",
                style: AppTextStyles.primaryBold.copyWith(
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: 7.0,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 7.0, left: 2.0),
                  child: SvgPicture.asset(
                    'assets/favorites_icon.svg',
                    height: 32,
                    width: 32,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
