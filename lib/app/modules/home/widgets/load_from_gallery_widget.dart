import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/style/colors.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../cubits/select_image/select_image_cubit.dart';

class LoadFromGalleryWidget extends StatelessWidget {
  LoadFromGalleryWidget({Key key}) : super(key: key);

  final _selectImageCubit = Modular.get<SelectImageCubit>();

  @override
  Widget build(BuildContext context) {
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
