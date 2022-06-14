import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';

import '../../shared/services/firestore_service.dart';
import '../../shared/style/colors.dart';
import '../../shared/widgets/custom_app_bar_widget.dart';
import '../../shared/widgets/permission_required_widget.dart';
import '../dashboard/cubits/favorites/favorites_cubit.dart';
import 'pages/favorites_page.dart';
import 'pages/motor_favorite_page.dart';

class WishlistPage extends StatefulWidget {
  final bool isMotorFavorite;

  const WishlistPage({Key key, this.isMotorFavorite = false}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final firestoreService = Modular.get<FirestoreService>();

  final _favoritesCubit = Modular.get<FavoritesCubit>();

  final authInstance = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _favoritesCubit.load();
  }

  @override
  Widget build(BuildContext context) {
    if (authInstance.currentUser != null) {
      return DefaultTabController(
        initialIndex: widget.isMotorFavorite ? 1 : 0,
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              CustomAppBarWidget(
                title: 'Wishlist',
              ),
              SizedBox(
                height: 13,
              ),
              TabBar(
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.white,
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Offers"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Models"),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    FavoritesPage(),
                    MotorsFavoritePage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            CustomAppBarWidget(
              title: "Wishlist",
            ),
            Expanded(
              child: PermissionRequiredWidget(currentContext: context),
            ),
          ],
        ),
      );
    }
  }
}
