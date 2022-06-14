import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/models/story_item_model.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/text_styles.dart';
import '../../shared/utils/analytics_helper.dart';
import '../../shared/widgets/dynamic_loading_widget.dart';
import '../home/cubits/plate_by_image/plate_by_image_cubit.dart';
import '../home/models/filter_model.dart';
import '../home/widgets/choose_plate_widget.dart';
import '../motor_details/motor_details_module.dart';
import 'cubits/recent_models/recent_models_cubit.dart';
import 'cubits/recent_offers/recent_offers_cubit.dart';
import 'widgets/recent_models_widget.dart';
import 'widgets/recent_searchs_widget.dart';
import 'widgets/stories_widget.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final authInstance = FirebaseAuth.instance;

  final _historyCubit = Modular.get<RecentOffersCubit>();
  final _recentModelsCubit = Modular.get<RecentModelsCubit>();

  @override
  void initState() {
    super.initState();

    _historyCubit.load();
    _recentModelsCubit.load();
  }

  double cardSize;

  final _storiesList = [
    StoryItem(
        filter: FilterOfferModel(
            price: "1000",
            priceMax: "3000",
            page: 1,
            pageSize: 10,
            sortOrder: 'expiryDate desc'),
        label: "Under 3k",
        assetImage: 'assets/stories/5k.jpeg'),
    StoryItem(
        filter: FilterOfferModel(
            price: "3001",
            priceMax: "5000",
            page: 1,
            pageSize: 10,
            sortOrder: 'expiryDate desc'),
        label: "3 to 5k",
        assetImage: 'assets/stories/10k.jpeg'),
    StoryItem(
        filter: FilterOfferModel(
            price: "5001",
            priceMax: "10000",
            page: 1,
            pageSize: 10,
            sortOrder: 'expiryDate desc'),
        label: "5 to 10k",
        assetImage: 'assets/stories/15k.jpeg'),
    StoryItem(
        filter: FilterOfferModel(
            price: "15000",
            priceMax: "20000",
            page: 1,
            pageSize: 10,
            sortOrder: 'expiryDate desc'),
        label: "10 to 20k",
        assetImage: 'assets/stories/20k.jpeg'),
    StoryItem(
        filter: FilterOfferModel(
            price: "20000",
            page: 1,
            pageSize: 10,
            sortOrder: 'expiryDate desc'),
        label: "20k+",
        assetImage: 'assets/stories/30k.jpeg')
    // StoryItem(
    //     filter: FilterOfferModel(
    //       price: "30000",
    //       priceMax: "40000",
    //       page: 1,
    //       pageSize: 10,
    //     ),
    //     label: "Under 40k",
    //     assetImage: 'assets/stories/40k.jpeg'),
    // StoryItem(
    //     filter: FilterOfferModel(
    //       price: "40000",
    //       priceMax: "50000",
    //       page: 1,
    //       pageSize: 10,
    //     ),
    //     label: "Under 50k",
    //     assetImage: 'assets/stories/50k.jpeg'),
    // StoryItem(
    //     filter: FilterOfferModel(
    //       price: "50000",
    //       priceMax: "75000",
    //       page: 1,
    //       pageSize: 10,
    //     ),
    //     label: "Under 75k",
    //     assetImage: 'assets/stories/75k.jpeg'),
    // StoryItem(
    //     filter: FilterOfferModel(
    //       price: "75000",
    //       priceMax: "100000",
    //       page: 1,
    //       pageSize: 10,
    //     ),
    //     label: "Under 100k",
    //     assetImage: 'assets/stories/100k.jpeg'),
  ];

  final _plateImageValidateCubit = Modular.get<PlateByImageCubit>();

  void _handleStatePlateByImage(BuildContext context, PlateByImageState state) {
    state.maybeWhen(
      loadSuccess: (text) {
        Navigator.of(context)
            .pushNamed(MotorDetailsModule.route, arguments: text);
        AnalyticsHelper.registerScannedPlate(text);
      },
      loadFailure: (errorMessage) {
        Navigator.of(context).pushNamed(
          "/home/reinsert-plate",
          arguments: errorMessage,
        );
        AnalyticsHelper.registerNotFoundPlateByImage();
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<PlateByImageCubit, PlateByImageState>(
                  bloc: _plateImageValidateCubit,
                  listener: _handleStatePlateByImage,
                  builder: (_, state) {
                    return state.maybeWhen(
                      loadLoading: () => Padding(
                        padding: const EdgeInsets.only(top: 33.0, left: 13),
                        child: Center(child: DynamicLoadingWidget()),
                      ),
                      orElse: () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 30,
                              left: 30,
                              bottom: 20,
                              top: 20,
                            ),
                            child: Text(
                              "Kia Ora, Aotearoa!",
                              style: AppTextStyles.primaryBold.copyWith(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7,
                            ),
                            child: StoriesWidget(storiesList: _storiesList),
                          ),
                          Divider(
                            color: AppColors.lightGray,
                            height: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 33.0),
                            child: ChoosePlateWidget(),
                          ),
                          RecentModelsWidget(),
                          RecentSearchsWidget(),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
