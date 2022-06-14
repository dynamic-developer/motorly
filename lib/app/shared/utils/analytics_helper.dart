import 'package:firebase_analytics/firebase_analytics.dart';
import '../constants/analytics_constants.dart';

// ignore: avoid_classes_with_only_static_members
class AnalyticsHelper {
  //app init event;
  static void registerOpenApp() {
    FirebaseAnalytics().logAppOpen();
  }

  //register tapped offer event;
  static void registerTappedOffer(String offer) {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.offerClickedEvent,
      parameters: {AnalyticsConstants.offerObject: offer},
    );
  }

  static void tappedFacebookMarketplace() {
    FirebaseAnalytics()
        .logEvent(name: AnalyticsConstants.tappedFacebookMarketPlace);
  }

  //register tutorial page event;
  static void setTutorialPage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.tutorialPage);
  }

  //register search plate page event;
  static void setSearchPage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.searchPage);
  }

  //register sign up page event;
  static void setSignUpPage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.signUpPage);
  }

  //register login page event;
  static void setLogInPage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.logInPage);
  }

  //register reset password page event;
  static void setResetPasswordPage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.resetPasswordPage);
  }

  //register reinsert plate page event;
  static void setReinsertPage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.reinsertPlatePage);
  }

  //register home page event;
  static void setHomePage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.homePage);
  }

  //register camera instruction page event;
  static void setCameraInstructionPage() {
    FirebaseAnalytics().setCurrentScreen(
        screenName: AnalyticsConstants.cameraInstructionsPage);
  }

  //register car details page event;
  static void setCarDetailsPage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.carDetailsPage);
  }

  //register car details page event;
  static void setKeywordsSearchPage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.keywordsSearchPage);
  }

  //register car details page event;
  static void setMarketPage() {
    FirebaseAnalytics()
        .setCurrentScreen(screenName: AnalyticsConstants.marketsPage);
  }

//register when user started the tutorial;
  static void registerTutorialBegin() {
    FirebaseAnalytics().logTutorialBegin();
  }

//register when user concluded the tutorial;
  static void registerTutorialComplete() {
    FirebaseAnalytics().logTutorialComplete();
  }

//register when user created account by email and password;
  static void registerSignUpByEmailPassword() {
    FirebaseAnalytics().logSignUp(
      signUpMethod: AnalyticsConstants.emailPasswordType,
    );
  }

//register when user started the signup;
  static void registerBeginSignUp() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.signUpEvent);
  }

//register when user reseted the password;
  static void registerPasswordReset() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.resetPasswordEvent);
  }

//register when user logged with email and password;
  static void registerLogInByEmailPassword() {
    FirebaseAnalytics()
        .logLogin(loginMethod: AnalyticsConstants.emailPasswordType);
  }

//register when user inserted plate;
  static void registerInsertedPlate(String plate) {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.searchPlateByTextEvent,
      parameters: {AnalyticsConstants.plateObject: plate},
    );
  }

  //register when user search by free text;
  static void registerFreeSearchText(String text) {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.freeSearchByTextEvent,
      parameters: {AnalyticsConstants.freeTextObject: text},
    );
  }

//register when user scanned plate;
  static void registerScannedPlate(String plate) {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.searchPlateByImageEvent,
      parameters: {AnalyticsConstants.plateObject: plate},
    );
  }

//register when founded plate;
  static void registerFoundedPlate(String plate) {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.foundedPlateEvent,
      parameters: {AnalyticsConstants.plateObject: plate},
    );
  }

//register when not founded plate by image;
  static void registerNotFoundPlateByImage() {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.notFoundedPlateByImageEvent,
    );
  }

//register when plate not founded by API;
  static void registerNotFoundPlateByApi(String message) {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.notFoundPlateByApiEvent,
      parameters: {
        AnalyticsConstants.errorObject: message,
      },
    );
  }

//register when user took picture to recognize plate;
  static void registerTookPicture() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.tookPictureEvent);
  }

  //register when user started the scanner;
  static void registerScannerOpen() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.scannerOpenEvent);
  }

  //register when user apply filter;
  static void registerSearchFilter() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.searchFilterEvent);
  }

  static void tappedSeeOfferOnTrademe(String offer) {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.tappedSeeOfferOnTrademe,
      parameters: {AnalyticsConstants.offerObject: offer},
    );
  }

  static void tappedSeeOfferOnTrademeFromFav(String offer) {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.tappedSeeOfferOnTrademeFromFav,
      parameters: {AnalyticsConstants.offerObject: offer},
    );
  }

  static void tappedStory(String price) {
    FirebaseAnalytics().logEvent(
      name: AnalyticsConstants.tappedStory,
      parameters: {AnalyticsConstants.price: price},
    );
  }

  static void tappedBrowseAll() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.tappedBrowseAll);
  }

  static void sharedOffer() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.sharedOffer);
  }

  static void sharedModel() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.sharedModel);
  }

  static void viewSharedOffer() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.viewSharedOffer);
  }

  static void viewSharedModel() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.viewSharedModel);
  }

  static void viewWishList() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.viewWishList);
  }

  static void tappedWishListOfferItem() {
    FirebaseAnalytics()
        .logEvent(name: AnalyticsConstants.tappedWishListOfferItem);
  }

  static void tappedWishListModels() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.viewWishListModels);
  }

  //Will require refactoring given widget is shared with last scans
  // static void tappedWishListModelItem() {
  //   FirebaseAnalytics()
  //       .logEvent(name: AnalyticsConstants.tappedWishListModelItem);
  // }

  static void tappedSearchFromAppBar() {
    FirebaseAnalytics()
        .logEvent(name: AnalyticsConstants.tappedSearchFromAppBar);
  }

  static void tappedLastScans() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.tappedLastScans);
  }

  static void tappedRecentOffers() {
    FirebaseAnalytics().logEvent(name: AnalyticsConstants.tappedRecentOffers);
  }

  //Will require refactoring given widget is shared with fav
  // static void tappedLastScansItem() {
  //   FirebaseAnalytics().logEvent(name: AnalyticsConstants.tappedLastScanItem);
  // }

  //Will require refactoring given widget is shared with fav
  // static void tappedRecentOffersItem() {
  //   FirebaseAnalytics()
  //       .logEvent(name: AnalyticsConstants.tappedRecentOffersItem);
  // }

}
