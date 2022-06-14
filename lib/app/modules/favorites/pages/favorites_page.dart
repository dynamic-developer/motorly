import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/widgets/custom_button_widget.dart';
import '../../dashboard/cubits/favorites/favorites_cubit.dart';
import '../../home/cubits/navigation/navigation.cubit.dart';
import '../../home/widgets/item_offer_widget.dart';
import '../../motor_details/widgets/shimmer_offers.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final firestoreService = Modular.get<FirestoreService>();

  final _favoritesCubit = Modular.get<FavoritesCubit>();

  final authInstance = FirebaseAuth.instance;

  final _navigationCubit = Modular.get<NavigationCubit>();

  @override
  void initState() {
    super.initState();
    _favoritesCubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: _favoritesCubit,
      builder: (context, state) {
        if (state is FavoritesFailure) {
          return _buildError(state.error);
        }

        if (state is FavoritesLoaded) {
          if (state.data.isEmpty) {
            return _buildNoData(context);
          }
          return _buildLoaded(state.data);
        }
        return _buildProgressIndicator();
      },
    );
  }

  Widget _buildLoaded(data) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          data.length,
          (index) => Padding(
            padding: const EdgeInsets.all(13.0),
            child: ItemOfferWidget(offer: data[index]),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadius,
        color: AppColors.backgroundCard.withOpacity(0.4),
      ),
      child: Center(
        child: Text("Something went wrong: $message"),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Shimmer.fromColors(
        baseColor: AppColors.gray70,
        highlightColor: AppColors.backgroundWidget,
        enabled: true,
        child: ShimmerOffersWidget(),
      ),
    );
  }

  Widget _buildNoData(context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadius,
        color: AppColors.backgroundCard.withOpacity(0.4),
      ),
      padding: AppDimensions.marginScreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sorry, there are no favorites. Click\n"
            "the button below and start the search :).",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            child: CustomButtonWidget(
              text: "Get Started",
              onTap: () {
                _navigationCubit.emit(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
