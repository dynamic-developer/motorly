import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';

import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../favorites/cubits/motors_favorite/check_motor_favorite_cubit.dart';
import '../../home/models/old_motor_model.dart';
import '../../motor_details/motor_details_module.dart';
import '../cubits/motors_favorite/motor_favorites_cubit.dart';

class ItemMotorFavoriteWidget extends StatefulWidget {
  final MotorModel motor;
  ItemMotorFavoriteWidget({this.motor});

  @override
  _ItemMotorFavoriteWidgetState createState() =>
      _ItemMotorFavoriteWidgetState();
}

class _ItemMotorFavoriteWidgetState extends State<ItemMotorFavoriteWidget> {
  final firestoreService = Modular.get<FirestoreService>();

  final _checkFavoritesCubit = Modular.get<CheckMotorFavoritesCubit>();
  final _motorsFavoriteCubit = Modular.get<MotorsFavoritesCubit>();

  @override
  void initState() {
    super.initState();
    _checkFavoritesCubit.load(widget.motor);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckMotorFavoritesCubit, CheckMotorFavoritesState>(
        bloc: _checkFavoritesCubit,
        builder: (context, state) {
          return Stack(
            children: [
              _buildContent(context, widget.motor),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: state is CheckMotorFavorite
                      ? Icon(
                          Icons.favorite,
                          color: AppColors.primary,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                  onPressed: () {
                    firestoreService.removeFavoritesMotor(
                      motor: widget.motor,
                    );
                    _motorsFavoriteCubit.load();
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget _buildContent(context, MotorModel motor) {
    return InkWell(
      onTap: () => {
        //AnalyticsHelper.tappedWishListModelItem(),
        Navigator.of(context).pushNamed(
          MotorDetailsModule.route,
          arguments: motor.plate.toString(),
        )
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: AppDimensions.borderRadius,
        ),
        height: 150,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset("assets/icon/favorite-car.svg"),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: AppDimensions.borderRadius,
                      border: Border.all(
                          color: Color.fromRGBO(193, 12, 69, 1), width: 3),
                    ),
                    child: Text(
                      widget.motor?.plate?.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.primaryPlateStyle,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 5,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '${widget.motor?.year} ${widget.motor?.make} ${widget.motor?.model}',
                        style: AppTextStyles.primaryMotorDetailBold.copyWith(
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Engine Size - ${widget.motor?.engineSize} | Fuel Type - (${widget.motor?.fuelType})',
                      style: AppTextStyles.primaryCountLimitsBold.copyWith(
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
