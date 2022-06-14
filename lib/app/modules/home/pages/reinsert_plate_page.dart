import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../widgets/insert_plate_widget.dart';

class ReinsertPlatePage extends StatelessWidget {
  final String imageByteArray;

  ReinsertPlatePage({@required this.imageByteArray});
  Widget build(BuildContext context) {
    AnalyticsHelper.setReinsertPage();

    var imageData = base64Decode(imageByteArray);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
        body: Stack(children: [
      SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            if (imageData != null)
              Container(
                width: screenWidth,
                constraints: BoxConstraints(maxHeight: screenHeight * 0.68),
                child: InteractiveViewer(
                    panEnabled: false, // Set it to false
                    boundaryMargin: EdgeInsets.all(100),
                    minScale: 0.5,
                    maxScale: 2,
                    child: Image.memory(imageData)),
              ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Ooops...',
                style: AppTextStyles.primaryMotorDetailBold.copyWith(
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'We couldn\'t recognize this car.',
                style: AppTextStyles.primaryBoldDescription.copyWith(
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
            Center(
              child: Text(
                'Please enter the plate number below :)',
                style: AppTextStyles.primaryInfoDescription.copyWith(
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 320,
              child: InsertPlateWidget(),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 42.0, left: 7),
        child: Container(
          height: 50,
          alignment: Alignment.topLeft,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).canvasColor == Colors.white
                ? Color.fromRGBO(0, 0, 0, 0.20)
                : Color.fromRGBO(255, 255, 255, 0.20),
            child: Icon(
              Icons.keyboard_arrow_left,
              size: 33,
              color: AppColors.primary,
            ),
            onPressed: () {
              Navigator.of(context).pop(context);
            },
          ),
        ),
      )
    ]));

    //   return Scaffold(
    //     resizeToAvoidBottomInset: true,
    //     body: Stack(
    //       children: [
    //         if (imageData != null)
    //           InteractiveViewer(
    //               panEnabled: false, // Set it to false
    //               boundaryMargin: EdgeInsets.all(100),
    //               minScale: 0.5,
    //               maxScale: 2,
    //               child: Image.memory(imageData)),
    //         SingleChildScrollView(
    //           physics: ClampingScrollPhysics(),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               SizedBox(
    //                 height: MediaQuery.of(context).size.height * 0.6,
    //               ),
    //               Center(
    //                 child: Text(
    //                   'Ooops...',
    //                   style: AppTextStyles.primaryMotorDetailBold.copyWith(
    //                     color: Theme.of(context).canvasColor,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 26,
    //               ),
    //               Center(
    //                 child: Text(
    //                   'Sorry, we couldn\'t recognize this car.',
    //                   style: AppTextStyles.primaryBoldDescription.copyWith(
    //                     color: Theme.of(context).canvasColor,
    //                   ),
    //                 ),
    //               ),
    //               Center(
    //                 child: Text(
    //                   'Please type the plate number below :)',
    //                   style: AppTextStyles.primaryInfoDescription.copyWith(
    //                     color: Theme.of(context).canvasColor,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 13,
    //               ),
    //               SizedBox(
    //                 width: 320,
    //                 child: InsertPlateWidget(),
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   );
  }
}
