import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/widgets/custom_button_widget.dart';
import '../../home/cubits/navigation/navigation.cubit.dart';
import '../../home/models/models.dart';
import '../../motor_details/widgets/shimmer_offers.dart';
import '../cubits/motors_favorite/motor_favorites_cubit.dart';
import '../widgets/item_motor_favorite_widget.dart';

class MotorsFavoritePage extends StatefulWidget {
  @override
  _MotorsFavoritePageState createState() => _MotorsFavoritePageState();
}

class _MotorsFavoritePageState extends State<MotorsFavoritePage> {
  final firestoreService = Modular.get<FirestoreService>();

  final _motorsFavoriteCubit = Modular.get<MotorsFavoritesCubit>();

  final authInstance = FirebaseAuth.instance;

  final _navigationCubit = Modular.get<NavigationCubit>();

  @override
  void initState() {
    super.initState();
    _motorsFavoriteCubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MotorsFavoritesCubit, MotorsFavoritesState>(
      bloc: _motorsFavoriteCubit,
      builder: (context, state) {
        if (state is MotorsFavoritesFailure) {
          return _buildError(state.error);
        }

        if (state is MotorsFavoritesLoaded) {
          if (state.data.isEmpty) {
            return _buildNoData(context);
          }
          return _buildLoaded(state.data, context);
        }
        return _buildProgressIndicator();
      },
    );
  }

  Widget _buildLoaded(List<MotorModel> data, context) {
    //AnalyticsHelper.tappedWishListModels();
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          data.length,
          (index) => Padding(
            padding: const EdgeInsets.all(13.0),
            child: ItemMotorFavoriteWidget(motor: data[index]),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
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
        child: ShimmerOffersWidget(
          height: 100,
        ),
      ),
    );
  }

  Widget _buildNoData(context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadius,
      ),
      padding: AppDimensions.marginScreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sorry, there are no favorites motors. Click\n"
            "the button below and start the search :).",
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
