import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

// import 'package:shake/shake.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/services/dynamic_link_service.dart';
import '../../shared/utils/analytics_helper.dart';
import '../../shared/widgets/custom_bottom_navigator_widget.dart';
import '../dashboard/dashboard_page.dart';
import '../favorites/wishlist_page.dart';
import '../my_account/pages/profile_page.dart';
import '../search/search_page.dart';
import 'cubits/filter/filter.cubit.dart';
import 'cubits/navigation/navigation.cubit.dart';
import 'models/filter_model.dart';
//import 'cubits/select_image/select_image_cubit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _navigationCubit = Modular.get<NavigationCubit>();
  final _filterCubit = Modular.get<FilterCubit>();
  //ShakeDetector detector;
  //final _selectImageCubit = Modular.get<SelectImageCubit>();

  void initDynamicLink() async {
    await DynamicLinkService().initDynamicLinks();
  }

  @override
  void initState() {
    super.initState();

    initDynamicLink();
    _tabController = TabController(
      length: 4,
      initialIndex: 0,
      vsync: this,
    );

    // detector = ShakeDetector.waitForStart(onPhoneShake: () async {
    //   if (await Navigator.of(context).canPop()) {
    //     Navigator.of(context).pop(context);
    //   }
    //   _navigationCubit.emit(1);
    //   var _prefs = await SharedPreferences.getInstance();
    //   var _notFirstCameraOpen = _prefs.getBool('notFirstCameraOpen') ?? false;
    //   print(_notFirstCameraOpen);
    //   if (_notFirstCameraOpen) {
    //     AnalyticsHelper.registerScannerOpen();
    //     _selectImageCubit.loadByCamera(context);
    //   } else {
    //     Navigator.of(context).pushNamed('/home/camera-instructions');
    //   }
    // });
    // detector.startListening();
  }

  @override
  void dispose() {
    super.dispose();
    //detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsHelper.setHomePage();

    return BlocConsumer<NavigationCubit, int>(
      listener: (context, state) {
        setState(() {
          _tabController.index = state;
        });
      },
      bloc: _navigationCubit,
      builder: (context, state) => WillPopScope(
        onWillPop: () async {
          if (state == 0) {
            print("EXIT");
            return true;
          } else {
            _navigationCubit.emit(0);
          }

          return false;
        },
        child: Scaffold(
          bottomNavigationBar: CustomBottomAppBar(
            items: [
              CustomAppBarItem(
                title: "Home",
                svgPath: 'assets/icon/icon-home.svg',
              ),
              CustomAppBarItem(
                title: "Search",
                icon: Icons.search,
              ),
              CustomAppBarItem(
                title: "Wishlist",
                icon: Icons.favorite,
              ),
              CustomAppBarItem(
                title: "Profile",
                svgPath: 'assets/icon/icon-profile.svg',
              ),
            ],
            onTabSelected: (index) {
              print("TAB PRESSED");
              if (index != _tabController.index) {
                print("TAB CHANGED");
                if (index == 1) {
                  AnalyticsHelper.tappedSearchFromAppBar();
                  _filterCubit.emit(FilterOfferModel(
                      page: 1, pageSize: 10, sortOrder: "expiryDate desc"));
                }

                if (index == 2) {
                  AnalyticsHelper.viewWishList();
                }

                _navigationCubit.emit(index);
              }
            },
            selectedIndex: state,
          ),
          body: SafeArea(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                DashboardPage(),
                BlocConsumer<FilterCubit, FilterOfferModel>(
                    listenWhen: (previous, current) => previous != current,
                    listener: (context, state) => print(state),
                    bloc: _filterCubit,
                    builder: (context, state) {
                      return SearchPage(
                        args: SearchArgs(keyword: "", filter: state),
                      );
                    }),
                WishlistPage(),
                ProfilePage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
