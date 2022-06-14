import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart'
    as custom_tabs_launcher;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../../../shared/widgets/custom_app_bar_widget.dart';
import '../../../shared/widgets/custom_button_widget.dart';
import '../../../shared/widgets/custom_fullscreen_loader_widget.dart';
import '../../authentication/authentication_page.dart';
import '../../dashboard/cubits/favorites/check_favorite_cubit.dart';
import '../../home/cubits/loader/loader.cubut.dart';
import '../../home/models/new_offer_model.dart';
import '../../home/widgets/share_widget.dart';
import '../../motor_details/widgets/details_bar_widget.dart';
import '../widgets/item_image_preview_widget.dart';

class OfferDetailsPage extends StatefulWidget {
  final NewOfferModel offer;

  OfferDetailsPage({@required this.offer});
  @override
  _OfferDetailsPageState createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  Future<void> _launchInBrowser(String url) async {
    try {
      custom_tabs_launcher.launch(url);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      if (await url_launcher.canLaunch(url)) {
        await url_launcher.launch(url,
            forceWebView: true, enableJavaScript: true);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  final authInstance = FirebaseAuth.instance;
  final firestoreService = Modular.get<FirestoreService>();

  final _checkFavoritesCubit = Modular.get<CheckFavoritesCubit>();
  bool _isVisible;

  final CarouselController _carouselController = CarouselController();

  final _loaderCubit = Modular.get<LoaderCubit>();

  @override
  void initState() {
    _checkFavorite(widget.offer);
    super.initState();
  }

  void _checkFavorite(NewOfferModel offer) async {
    _isVisible = await _checkFavoritesCubit.load(offer);
  }

  @override
  Widget build(BuildContext context) {
    var _formatter = NumberFormat.decimalPattern("en_NZ");
    final screenHeight = MediaQuery.of(context).size.height;
    int _index = -1;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.1),
                // Added the Tap Gesture to whole slider insted of Perticular Image to fix Double Tap issue
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 250),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, -0.2);
                          const end = Offset(0.0, 0.0);
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ItemImagePreview(
                          imageUrl: widget.offer.pictures,
                          currentIndex: _index,
                          onClose: (page) {
                            _carouselController.jumpToPage(page.toInt());
                          },
                        ),
                      ),
                    );
                  },
                  child: CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          _index = index;
                        },
                        aspectRatio: 4 / 3,
                        viewportFraction: 0.7,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal),
                    items: widget.offer.pictures.map((image) {
                      return Builder(
                        builder: (context) {
                          return _buildImage(image);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: AppDimensions.marginScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(widget.offer.title),
                    SizedBox(height: 7),
                    Divider(color: Colors.white),
                    Row(
                      children: [
                        Expanded(child: _buildContent(widget.offer), flex: 2),
                        Expanded(
                            child: Container(
                                child: Text(
                                    '${NumberFormat.simpleCurrency(decimalDigits: 0).format(widget.offer?.price)}',
                                    style: AppTextStyles.primaryH1Medium
                                        .copyWith(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold)),
                                alignment: Alignment.topRight))
                      ],
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Center(
                        child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: DetailsBarWidget(
                                odometerDescription:
                                    "${_formatter.format(widget.offer.carDetails.odometer)} km",
                                fuelDescription: widget.offer.carDetails.fuel,
                                bodyType: widget.offer.carDetails.bodystyle,
                                engineSize: widget
                                            .offer.carDetails.engineSize ==
                                        0
                                    ? null
                                    : "${_formatter.format(widget.offer.carDetails.engineSize)} cc",
                                transmission:
                                    widget.offer.carDetails.transmission,
                                seats: widget.offer.carDetails.seats.toString(),
                                is4WD: widget.offer.carDetails.is4WD))),
                    SizedBox(height: 33),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: CustomButtonWidget(
                            buttonWidth:
                                MediaQuery.of(context).size.width * 0.8,
                            text: "See Offer (Trade Me)",
                            onTap: () => {
                              AnalyticsHelper.tappedSeeOfferOnTrademe(
                                  widget.offer.title),
                              _launchInBrowser(widget.offer.link)
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
          CustomAppBarWidget(),
          BlocConsumer<LoaderCubit, bool>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) => print(state),
              bloc: _loaderCubit,
              builder: (context, state) {
                if (state) {
                  return CustomFullscreenLoaderWidget();
                }
                return Container();
              }),
        ],
      ),
    );
  }

  Widget _buildContent(NewOfferModel item) {
    var _subModel = (item?.carDetails?.subModel != null &&
            item?.carDetails?.subModel != 'null' &&
            item?.carDetails?.subModel != '' &&
            item?.carDetails?.subModel?.isNotEmpty == true)
        ? '${item?.carDetails?.subModel}'
        : '';

    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            '${item?.carDetails?.make} ${item?.carDetails?.model} ${item?.carDetails?.year} $_subModel',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: AppTextStyles.primaryH1Light.copyWith(
              color: AppColors.lightGray,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${item?.location}',
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
        builder: (context) => Row(children: [
              Expanded(
                child: Text(
                  '$title',
                  maxLines: 3,
                  style: AppTextStyles.primaryH1Regular.copyWith(
                    color: Theme.of(context).canvasColor,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                width: 13,
              ),
              ShareWidget(shareType: ShareType.offer, offer: widget.offer),
              SizedBox(
                width: 13,
              ),
              BlocBuilder<CheckFavoritesCubit, CheckFavoritesState>(
                  bloc: _checkFavoritesCubit,
                  builder: (context, state) {
                    var _isFavoritesPage =
                        ModalRoute.of(context).settings.name == "/favorites";

                    void showButton(offer) async {
                      if (authInstance.currentUser != null) {
                        _isVisible = await _checkFavoritesCubit.load(offer);
                        if (state is CheckFavoritesLoaded) {
                          if (_isVisible == false) {
                            var _text = await firestoreService.addFavorites(
                                offer: offer);
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(_favoritesSnackBar(_text));
                          } else {
                            var _text = await firestoreService.removeFavorites(
                                offer: offer);

                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(_favoritesSnackBar(_text));
                          }
                        }
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      }
                    }

                    return Visibility(
                        visible: _isFavoritesPage
                            ? _isVisible ?? true
                            : _isVisible ?? false,
                        child: Container(
                          width: 36,
                          height: 36,
                          child: state is CheckFavoritesLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : FloatingActionButton(
                                  heroTag: widget.offer,
                                  backgroundColor:
                                      Color.fromRGBO(193, 12, 69, 1),
                                  child: Visibility(
                                      child: state is CheckFavoritesLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Icon(Icons.favorite,
                                              color: Colors.white)),
                                  onPressed: () /*=> setState(() */ async {
                                    if (authInstance.currentUser != null) {
                                      await showButton(widget.offer);
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (context) =>
                                              AuthenticationPage(
                                                  isOriginHome: false,
                                                  callBack: () async => {
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
                              ? CircularProgressIndicator(color: Colors.white)
                              : FloatingActionButton(
                                  heroTag: widget.offer,
                                  backgroundColor:
                                      Color.fromRGBO(193, 12, 69, 1),
                                  child: state is CheckFavoritesLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : Icon(Icons.favorite_border,
                                          color: Colors.white),
                                  onPressed: () /*=> setState(() */ async {
                                    if (authInstance.currentUser != null) {
                                      await showButton(widget.offer);
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (context) =>
                                              AuthenticationPage(
                                                  isOriginHome: false,
                                                  callBack: () async => {
                                                        await showButton(
                                                            widget.offer)
                                                      }),
                                        ),
                                      );
                                    }
                                  }),
                        ));
                  })
            ]));
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
