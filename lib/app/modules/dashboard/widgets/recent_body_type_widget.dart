import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/utils/functions.dart';

class RecentBodyTypeWidget extends StatelessWidget {
  final String bodyType;

  RecentBodyTypeWidget({this.bodyType});

  @override
  Widget build(BuildContext context) {
    return _buildImage(context);
  }

  Widget _buildImage(BuildContext context) {
    return bodyTypeToImage(bodyType) != ''
        ? Container(
            width: 40,
            child: SvgPicture.asset(
                'assets/bodytype/${bodyTypeToImage(bodyType)}.svg'),
          )
        : Container();
  }
}
