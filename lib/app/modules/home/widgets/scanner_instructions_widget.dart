import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ScannerInstructionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        Theme.of(context).canvasColor == Colors.white
            ? 'assets/icon/scan-instructions.svg'
            : 'assets/icon/scan-instructions-white.svg',
        height: 120,
      ),
    );
  }
}
