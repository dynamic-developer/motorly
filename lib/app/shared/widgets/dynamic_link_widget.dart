import 'package:flutter/material.dart';

import '../models/dynamic_link_model.dart';
import '../utils/dynamic_link_helper.dart';

class DynamicLinkWidget extends StatelessWidget {
  const DynamicLinkWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DynamicLinkModel>(
      valueListenable:
          DynamicLinkHelper.appDynamicLinkHelper.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value.plate != null && value.offer != null) {
          return Container(child: Center(child: CircularProgressIndicator()));
        } else {
          return Container();
        }
      },
    );
  }
}
