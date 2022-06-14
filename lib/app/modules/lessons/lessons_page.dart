import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/style/colors.dart';
import '../../shared/style/text_styles.dart';
import '../../shared/utils/analytics_helper.dart';
import '../../shared/widgets/custom_button_widget.dart';

//import '../../../shared/style/colors.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  void _nextPage() {
    _controller.nextPage();
  }

  final List<Map<String, dynamic>> items = [
    {
      "image-light": "lesson1-white.svg",
      "image-dark": "lesson1-black.svg",
      "buttonText": "Next Step",
      "title": "Welcome to Motorly",
      "description": "The car you love is one snap away!\n\n",
    },
    {
      "image-light": "lesson2-white.svg",
      "image-dark": "lesson2-black.svg",
      "title": "How much is that car?",
      "buttonText": "Let's start!",
      "description":
          "Scan or enter a license plate to discover details, offers, reviews and more!",
    },
    // {
    //   "image-light": "lesson3-white.svg",
    //   "image-dark": "lesson3-black.svg",
    //   "title": "Save time and money!",
    //   "description":
    //       "Scan and find similar offers to make sure it's a good deal!",
    //   "buttonText": "Let's start!",
    // }
    // {
    //   "image-light": "lesson4-white.svg",
    //   "image-dark": "lesson4-black.svg",
    //   "title": "Explore the World",
    //   "buttonText": "Let\'s start!",
    //   "description": "Engaging and fun way to discover and shop motors",
    // },
    // {
    //    "image-light": "lesson5-white.svg",
    //   "image-dark": "lesson5-black.svg",
    //   "title": "Enable Camera",
    //    "buttonText": "Let\'s start!",
    //   "description":
    //       "Please provide us with access to your camera, which is required to scan the car",
    // }
    //,
    // {
    //   "image-light": "lesson2-white.svg",
    //   "image-dark": "shake-to-scan.svg",
    //   "title": "Shake to Scan",
    //   "buttonText": "Let\'s start!",
    //   "description": "You can shake the cell phone to access the camera!",
    // },
  ];

  void onPressedNextButton() async {
    if (items[_current]["buttonText"] == "Next Step") {
      _nextPage();
    } else {
      //Navigator.popAndPushNamed(context, "/authentication");

      var _prefs = await SharedPreferences.getInstance();
      await _prefs.setBool('isFirstOpen', false);
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      AnalyticsHelper.registerTutorialComplete();
    }
  }

  @override
  void initState() {
    super.initState();
    AnalyticsHelper.setTutorialPage();
    AnalyticsHelper.registerTutorialBegin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              _buildCarrousel(),
              // if (_current < items.length - 1) _buildSkipButton(),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20),
                _buildIndicators(),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    items[_current]["title"],
                    style: AppTextStyles.primaryBold.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Text(
                        items[_current]["description"],
                        style: AppTextStyles.primaryBoldDescription,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: CustomButtonWidget(
                    text: items[_current]["buttonText"],
                    onTap: onPressedNextButton,
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
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

  // ignore: unused_element
  _buildSkipButton() async {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(right: 26, top: 42),
        child: InkResponse(
          child: Text('Skip', style: AppTextStyles.primaryPinkBold),
          onTap: () async {
            //Navigator.popAndPushNamed(context, "/authentication");
            var _prefs = await SharedPreferences.getInstance();
            await _prefs.setBool('isFirstOpen', false);

            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          },
        ),
      ),
    );
  }

  Widget _buildCarrousel() {
    final text = (Theme.of(context).canvasColor == Colors.white)
        ? "image-dark"
        : "image-light";
    return CarouselSlider(
      items: List.generate(
        items.length,
        (index) {
          return Container(
            color: Theme.of(context).backgroundColor,
            width: double.infinity,
            child: InkResponse(
              child: SvgPicture.asset(
                "assets/ilustrations/${items[index][text]}",
                fit: BoxFit.scaleDown,
              ),
            ),
          );
        },
      ),
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1,
        height: MediaQuery.of(context).size.height / 2.0,
        onPageChanged: (index, reason) {
          setState(() => _current = index);
        },
      ),
      carouselController: _controller,
    );
  }
}
