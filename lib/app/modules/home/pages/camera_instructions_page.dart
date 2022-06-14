import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../../../shared/widgets/custom_button_widget.dart';
import '../cubits/select_image/select_image_cubit.dart';

class CameraInstructionsPage extends StatefulWidget {
  @override
  _CameraInstructionsPageState createState() => _CameraInstructionsPageState();
}

class _CameraInstructionsPageState extends State<CameraInstructionsPage> {
  SelectImageCubit _selectImageCubit;
  int _current = 0;

  final CarouselController _controller = CarouselController();

  void _nextPage() {
    _controller.nextPage();
  }

  final List<Map<String, dynamic>> items = [
    {
      "image": "camera-instruction.png",
      "buttonText": "Okay!",
      "description":
          "Make sure the plate number is visible when taking the picture!",
    }
    //,
    // {
    //   "image": "shake.png",
    //   "animation": "camera-instruction.png",
    //   "buttonText": "Get Started",
    //   "description": "You can shake the cell phone to access the camera!",
    // },
  ];

  void onPressedNextButton() async {
    if (items[_current]["buttonText"] == "Next Step") {
      _nextPage();
    } else {
      //Navigator.popAndPushNamed(context, "/authentication");
      Navigator.of(context).pop();
      var _prefs = await SharedPreferences.getInstance();
      await _prefs.setBool('notFirstCameraOpen', true);
      AnalyticsHelper.registerScannerOpen();

      _selectImageCubit.loadByCamera(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectImageCubit = Modular.get<SelectImageCubit>();
    AnalyticsHelper.setCameraInstructionPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildCarrousel()),
          _buildIndicators(),
          SizedBox(height: 50),
          Container(
            width: 320,
            height: 70,
            child: Center(
              child: Text(
                items[_current]["description"],
                style: AppTextStyles.primaryPriceLight,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.only(
              bottom: 70,
              left: 40,
              right: 40,
            ),
            child: CustomButtonWidget(
              text: items[_current]["buttonText"],
              onTap: onPressedNextButton,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarrousel() {
    return CarouselSlider(
      items: List.generate(
        items.length,
        (index) {
          return Container(
            color: Theme.of(context).backgroundColor,
            width: double.infinity,
            child: InkResponse(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/ilustrations/${items[index]["image"]}",
                    fit: BoxFit.scaleDown,
                  ),
                  if (index == 0)
                    Row(children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Flexible(
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            height: MediaQuery.of(context).size.width * 0.30,
                            child:
                                Lottie.asset('assets/car-instructions1.json')),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                      ),
                      Flexible(
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            height: MediaQuery.of(context).size.width * 0.30,
                            child:
                                Lottie.asset('assets/car-instructions2.json')),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ]),
                  //   ),
                  // if (index == 1)
                  //   Container(
                  //       width: MediaQuery.of(context).size.width * 0.30,
                  //       height: MediaQuery.of(context).size.width * 0.30,
                  //       child: Lottie.asset('assets/shake-scan.json')),
                ],
              ),
            ),
          );
        },
      ),
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1,
        height: MediaQuery.of(context).size.height / 2.4,
        onPageChanged: (index, reason) {
          setState(() => _current = index);
        },
      ),
      carouselController: _controller,
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        items.length,
        (index) => Container(
          width: 11,
          height: 11,
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 4.0,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index
                ? AppColors.primary
                : Theme.of(context).hoverColor,
          ),
        ),
      ),
    );
  }
}
