import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/utils/functions.dart';

class BodyTypeWidget extends StatelessWidget {
  final String bodyType;

  BodyTypeWidget({this.bodyType});

  @override
  Widget build(BuildContext context) {
    return _buildImage(context);
  }

  Widget _buildImage(BuildContext context) {
    return bodyTypeToImage(bodyType) != ''
        ? Container(
            width: MediaQuery.of(context).size.width * 0.20,
            child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SvgPicture.asset(
                    'assets/bodytype/${bodyTypeToImage(bodyType)}.svg')),
          )
        : Container();
  }
}
