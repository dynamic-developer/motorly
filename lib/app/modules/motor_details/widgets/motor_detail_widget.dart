import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../shared/instances/allow_buy_instance.dart';
import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../authentication/authentication_page.dart';
import '../../favorites/cubits/motors_favorite/check_motor_favorite_cubit.dart';
import '../../favorites/wishlist_page.dart';
import '../../home/models/models.dart';
import '../../home/widgets/share_widget.dart';
import '../cubits/check_purchase/check_purchase_cubit.dart';
import 'details_bar_widget.dart';
import 'purchase_report_widget.dart';
import '../../../shared/widgets/motorly_dialog_widget.dart';

class MotorDetailWidget extends StatefulWidget {
  final MotorModel motor;
  MotorDetailWidget({this.motor});

  @override
  _MotorDetailWidgetState createState() => _MotorDetailWidgetState();
}

class _MotorDetailWidgetState extends State<MotorDetailWidget> {
  final firestoreService = Modular.get<FirestoreService>();
  final authInstance = FirebaseAuth.instance;
  bool _expanded = true;
  final _checkPurchased = Modular.get<CheckPurchaseCubit>();

  final _checkFavoritesCubit = Modular.get<CheckMotorFavoritesCubit>();

  @override
  void initState() {
    super.initState();
    _checkPurchased.load(widget.motor.plate);

    //Future(checkStolenVehicle);

    getFavorite();
  }

  void checkStolenVehicle() {
    if (widget.motor != null) {
      showDialog(
        context: context,
        builder: (_) => MotorlyDialogWidget(
          title: "WARNING!!!",
          isLoading: false,
          description:
              "THIS VEHICLE HAS BEEN REPORTED AS STOLEN! Check with the police how to proceed.",
          action: () => Navigator.of(context).pop(),
          buttonTitle: 'Ok',
        ),
      );
    }
  }

  void getFavorite() async {
    await _checkFavoritesCubit.load(widget.motor);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckMotorFavoritesCubit, CheckMotorFavoritesState>(
        bloc: _checkFavoritesCubit,
        builder: (context, state) {
          void _handleFavorite() async {
            if (state is CheckMotorFavorite) {
              var _text = await firestoreService.removeFavoritesMotor(
                motor: widget.motor,
              );
              ScaffoldMessenger.of(context).removeCurrentSnackBar();

              ScaffoldMessenger.of(context)
                  .showSnackBar(_favoritesSnackBar(_text));
            } else {
              var _text =
                  await firestoreService.addFavoritesMotor(motor: widget.motor);
              ScaffoldMessenger.of(context).removeCurrentSnackBar();

              ScaffoldMessenger.of(context)
                  .showSnackBar(_favoritesSnackBar(_text));
            }
            _checkFavoritesCubit.load(widget.motor);
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ShareWidget(
                      shareType: ShareType.plate, motor: widget.motor),
                ),
              ),
              _buildContent(context),
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
                  onPressed: () async {
                    if (authInstance.currentUser != null) {
                      await _handleFavorite();
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => AuthenticationPage(
                              callBack: () async => await _handleFavorite()),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        });
  }

  SnackBar _favoritesSnackBar(String message) {
    var _firstClick = true;
    return SnackBar(
      backgroundColor: Color.fromRGBO(32, 32, 36, 1),
      content: InkWell(
        onTap: () => {
          if (_firstClick == true)
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => WishlistPage(
                  isMotorFavorite: true,
                ),
              ),
            ),
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

  Widget _buildContent(context) {
    var _formatter = NumberFormat.decimalPattern("en_NZ");

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: AppDimensions.borderRadius,
            border: Border.all(color: Color.fromRGBO(193, 12, 69, 1), width: 3),
          ),
          child: Text(
            widget.motor?.plate?.toUpperCase(),
            textAlign: TextAlign.center,
            style: AppTextStyles.primaryPlateStyle,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width * 3 / 4,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '  ${widget.motor?.year} ${widget.motor?.make} ${widget.motor?.model}',
              style: AppTextStyles.primaryMotorDetailBold.copyWith(
                color: Theme.of(context).canvasColor,
              ),
            ),
          ),
        ),
        if (widget.motor?.subModel != null &&
            widget.motor.subModel.isNotEmpty &&
            widget.motor.subModel != '' &&
            widget.motor.subModel != 'null' &&
            widget.motor.subModel != ' ')
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              widget.motor?.subModel,
              style: AppTextStyles.primaryCountLimitsBold.copyWith(
                color: Theme.of(context).canvasColor,
              ),
            ),
          ),
        SizedBox(
          height: 13,
        ),
        Divider(color: Colors.grey[800]),
        if (!_expanded)
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Details',
                  style: AppTextStyles.primaryCountLimitsBold
                      .copyWith(color: Colors.grey[700], fontSize: 13),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey[700])
              ],
            ),
            onTap: () => setState(() => {_expanded = true}),
          ),
        if (_expanded)
          Column(
            children: [
              InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Details',
                        style: AppTextStyles.primaryCountLimitsBold
                            .copyWith(color: Colors.grey[700], fontSize: 13),
                      ),
                      Icon(Icons.keyboard_arrow_up, color: Colors.grey[700]),
                    ],
                  ),
                  onTap: () => setState(() => {_expanded = false})),
              SizedBox(
                height: 13,
              ),
              DetailsBarWidget(
                  fuelDescription: widget.motor.fuelType,
                  bodyType: widget.motor.bodyType,
                  engineSize: [null, "", "0"].contains(widget.motor.engineSize)
                      ? null
                      : "${_formatter.format(int.parse(widget.motor.engineSize))} cc",
                  transmission: widget.motor.transmission,
                  seats: widget.motor.seats,
                  is4WD: widget.motor.is4WD),
              SizedBox(
                height: 5,
              ),
              if (AllowBuyInstance.instance.allowed &&
                  FirebaseAuth.instance.currentUser?.uid != null)
                Divider(color: Colors.grey[800]),
              SizedBox(
                height: 7,
              ),
              BlocBuilder<CheckPurchaseCubit, CheckPurchaseState>(
                bloc: _checkPurchased,
                builder: (context, state) {
                  if (state is CheckNoPurchase &&
                      AllowBuyInstance.instance.allowed &&
                      //TODO:show the button if the user is not logged in, but ask them to login if they click it.
                      FirebaseAuth.instance.currentUser?.uid != null) {
                    return PurchaseReportWidget(
                      motor: widget.motor,
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
      ],
    );
  }
}
