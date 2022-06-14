import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class HeadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 33.0),
        child: SvgPicture.asset(
          Theme.of(context).canvasColor == Colors.white
              ? 'assets/icon/logo-horizontal.svg'
              : 'assets/icon/logo-horizontal-white.svg',
          height: 64,
        ),
      ),
    );
  }
}
