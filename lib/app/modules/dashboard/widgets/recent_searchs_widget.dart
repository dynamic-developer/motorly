import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';

import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../home/models/new_offer_model.dart';
import '../../offers/offers_page.dart';
import '../cubits/recent_offers/recent_offers_cubit.dart';
import 'item_offer_widget.dart';

class RecentSearchsWidget extends StatelessWidget {
  final firestoreService = Modular.get<FirestoreService>();

  final _historyCubit = Modular.get<RecentOffersCubit>();

  final authInstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentOffersCubit, RecentOffersState>(
      bloc: _historyCubit,
      builder: (context, state) {
        if (state is RecentOffersFailure) {
          return Container();
        }

        if (state is RecentOffersLoaded) {
          if (state.data.isEmpty) {
            return Container();
          }
          return _buildLoaded(state.data);
        }
        return _buildProgressIndicator();
      },
    );
  }

  Widget _buildLoaded(List<NewOfferModel> offers) {
    return Builder(
      builder: (context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: _buildHead(offers, context),
            ),
            SizedBox(height: 20),
            _buildOptions(offers),
          ],
        ),
      ),
    );
  }

  // Widget _buildError(String message) {
  //   return Container(
  //     height: 200,
  //     decoration: BoxDecoration(
  //       borderRadius: AppDimensions.borderRadius,
  //       color: AppColors.backgroundCard.withOpacity(0.4),
  //     ),
  //     child: Center(
  //       child: Text("Something went wrong: $message"),
  //     ),
  //   );
  // }

  Widget _buildProgressIndicator() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildOptions(List<NewOfferModel> data) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 30, left: 30, bottom: 30),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          data.length,
          (index) => ItemOfferWidget(offer: data[index]),
        ),
      ),
    );
  }

  Widget _buildHead(List<NewOfferModel> data, context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Recently Viewed",
                    style: AppTextStyles.primaryBold.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                AnalyticsHelper.tappedRecentOffers();
                Navigator.of(context).pushNamed(
                  "/offers",
                  arguments: OffersArgs(
                    offers: data,
                    title: "Recently Viewed",
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                    "More",
                    style: AppTextStyles.primaryH0Bold.copyWith(
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: AppColors.primary,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
