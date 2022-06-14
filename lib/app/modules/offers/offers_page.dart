import 'package:flutter/material.dart';

import '../../shared/style/app_dimensions.dart';
import '../../shared/widgets/custom_app_bar_widget.dart';
import '../home/models/new_offer_model.dart';
import 'widgets/item_offer_widget.dart';

class OffersArgs {
  final String title;
  final List<NewOfferModel> offers;

  OffersArgs({@required this.offers, this.title = "Offers"});
}

class OffersPage extends StatefulWidget {
  final OffersArgs args;

  OffersPage({@required this.args});
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarWidget(
            title: widget.args.title,
          ),
          Expanded(
            child: ListView.separated(
              padding: AppDimensions.marginScreen.copyWith(top: 0),
              itemCount: widget.args.offers.length,
              itemBuilder: (_, index) => ItemOfferWidget(
                offer: widget.args.offers[index],
              ),
              separatorBuilder: (context, index) => SizedBox(height: 20),
            ),
          ),
        ],
      ),
    );
  }
}
