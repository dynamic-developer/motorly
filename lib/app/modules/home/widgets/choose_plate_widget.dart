import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../cubits/plate_by_image/plate_by_image_cubit.dart';
import '../cubits/select_image/select_image_cubit.dart';
import 'insert_plate_widget.dart';

class ChoosePlateWidget extends StatelessWidget {
  final _plateImageValidateCubit = Modular.get<PlateByImageCubit>();

  final _selectImageCubit = Modular.get<SelectImageCubit>();

  void _handleStateSelectImage(BuildContext context, SelectImageState state) {
    state.maybeWhen(
      loadLoaded: (image) {
        AnalyticsHelper.registerTookPicture();
        _plateImageValidateCubit.verify(image: image);
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsHelper.setSearchPage();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocListener<SelectImageCubit, SelectImageState>(
          bloc: _selectImageCubit,
          listener: _handleStateSelectImage,
          child: InkWell(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * .3,
                  width: MediaQuery.of(context).size.width * .3,
                  child: Lottie.asset('assets/button.json'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tap to identify a car",
                  style: AppTextStyles.primaryBold.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "Find out details, offers and more!!",
                  style: TextStyle(
                    color: Theme.of(context).hoverColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            onTap: () async {
              var _prefs = await SharedPreferences.getInstance();
              var _notFirstCameraOpen =
                  _prefs.getBool('notFirstCameraOpen') ?? false;
              print(_notFirstCameraOpen);
              if (_notFirstCameraOpen) {
                AnalyticsHelper.registerScannerOpen();
                _selectImageCubit.loadByCamera(context);
              } else {
                Navigator.of(context).pushNamed('/home/camera-instructions');
              }
            },
          ),
        ),
        SizedBox(height: 23),
        Column(
          children: [
            _buildDivider(),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: InsertPlateWidget(),
            ),
            const SizedBox(height: 33),
            _buildLoadFromGallery(),
            const SizedBox(height: 42),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 30.0, right: 10.0),
            child: Divider(
              color: AppColors.lightGray,
              height: 13,
            ),
          ),
        ),
        Text(
          "or",
          style: TextStyle(color: AppColors.lightGray, fontSize: 16),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 30.0),
            child: Divider(
              color: AppColors.lightGray,
              height: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadFromGallery() {
    return Builder(
      builder: (context) {
        return RichText(
          text: TextSpan(
            text: 'Do you have saved images?',
            style: TextStyle(
              color: Theme.of(context).hoverColor,
              fontSize: 13,
            ),
            children: <TextSpan>[
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    AnalyticsHelper.registerScannerOpen();
                    _selectImageCubit.loadByGallery();
                  },
                text: ' Load from gallery',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
