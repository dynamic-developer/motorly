import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/style/text_styles.dart';
import '../../../shared/utils/functions.dart';

class DetailsBarWidget extends StatelessWidget {
  final String odometerDescription;
  final String fuelDescription;
  final String bodyType;
  final String engineSize;
  final String transmission;
  final String seats;
  final bool is4WD;

  const DetailsBarWidget(
      {Key key,
      this.odometerDescription,
      this.fuelDescription,
      this.bodyType,
      this.engineSize,
      this.transmission,
      this.seats,
      this.is4WD = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 18, // gap between adjacent chips
          runSpacing: 20.0, // gap between lines
          alignment: WrapAlignment.center,
          children: [
            if (![null, ""].contains(odometerDescription))
              _buildImage(context, 'odometer', odometerDescription, 40, 30),
            if (![null, ""].contains(fuelDescription))
              _buildImage(context, 'fuel', fuelDescription, 23, 30),
            if (![null, "", "0"].contains(engineSize))
              _buildImage(context, 'engine', engineSize, 40, 30),
            if (![null, ""].contains(transmission))
              _buildImage(context, 'transmission', transmission, 40, 30),
            if (![null, ""].contains(bodyType) &&
                bodyTypeToImage(bodyType) != '')
              _buildImage(context, bodyTypeToImage(bodyType), bodyType, 40, 30),
            if (![null, "", "0"].contains(seats)) _buildSeats(context, seats),
            if (is4WD) _build4WD(context)
          ],
        ),
      ],
    );
  }
}

Widget _build4WD(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
          width: 50,
          height: 30,
          child: Center(
              child: Text(
            "4WD",
            style: AppTextStyles.primaryCountLimitsBold.copyWith(
                fontSize: 21,
                color: Color(0xFFD80A49),
                fontWeight: FontWeight.bold),
          ))),
      SizedBox(
        width: 7,
      ),
      Text(
        "Drive",
        style: AppTextStyles.primaryCountLimitsBold.copyWith(
          fontSize: 11,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget _buildSeats(BuildContext context, String seats) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
          width: 23,
          height: 30,
          child: Center(
              child: Text(
            seats,
            style: AppTextStyles.primaryCountLimitsBold.copyWith(
                fontSize: 21,
                color: Color(0xFFD80A49),
                fontWeight: FontWeight.bold),
          ))),
      SizedBox(
        width: 7,
      ),
      Text(
        "Seats",
        style: AppTextStyles.primaryCountLimitsBold.copyWith(
          fontSize: 11,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget _buildImage(BuildContext context, String image, String description,
    double width, double height) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: width,
        height: height,
        child: SvgPicture.asset('assets/bodytype/$image.svg'),
      ),
      SizedBox(
        width: 7,
      ),
      Text(
        '$description',
        style: AppTextStyles.primaryCountLimitsBold.copyWith(
          fontSize: 11,
          color: Colors.grey,
        ),
      ),
    ],
  );
}
