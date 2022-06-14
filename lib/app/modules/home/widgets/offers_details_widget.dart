import 'package:flutter/material.dart';

import '../../../shared/style/text_styles.dart';
import '../models/new_offer_model.dart';
import 'item_offer_widget.dart';

class OffersDetailsWidget extends StatelessWidget {
  final List<NewOfferModel> _offers;
  OffersDetailsWidget(this._offers, this.totalOffers);

  final int totalOffers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (totalOffers != 0) _buildCount(),
        SizedBox(height: 20),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _offers?.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(
              bottom: 27.0,
              right: 13,
              left: 13,
            ),
            child: ItemOfferWidget(
              offer: _offers[index],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCount() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "$totalOffers",
          style: AppTextStyles.primaryBold.copyWith(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        Text(
          " offers",
          style: AppTextStyles.primaryH1Light.copyWith(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Divider(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
