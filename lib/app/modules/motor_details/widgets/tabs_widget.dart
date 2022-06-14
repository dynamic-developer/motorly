import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget({Key key, this.url}) : super(key: key);
  final String url;
  Future<void> _launchInBrowser(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.only(bottom: 7.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 4.0, color: Color.fromRGBO(216, 10, 73, 1)))),
          child: Center(
            child: Container(
              height: 26,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Image.asset(
                'assets/ilustrations/trademe.png',
                scale: 0.8,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => {
            AnalyticsHelper.tappedFacebookMarketplace(),
            _launchInBrowser(url)
          },
          onHover: (value) {},
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            padding: const EdgeInsets.only(bottom: 7.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Container(
              height: 26,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Center(
                  child: SvgPicture.asset(
                'assets/ilustrations/facebook.svg',
                width: 121,
                height: 23,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
