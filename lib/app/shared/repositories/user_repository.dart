import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../utils/firebase_exception_to_message.dart';

class UserRepository {
  final authInstance = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final timeOutLimit = Duration(seconds: 15);

  Future<Either<String, User>> signUp({
    @required String email,
    @required String password,
    @required String username,
  }) async {
    try {
      var userCredential = await authInstance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .timeout(timeOutLimit);
      await userCredential.user
          .updateDisplayName(username)
          .timeout(timeOutLimit);
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseExceptionToMessage().get(e.code));
    }
  }

  Future<Either<String, User>> signInWithGoogle() async {
    try {
      final googleSignInAccount =
          await googleSignIn.signIn().timeout(timeOutLimit);

      final googleSignInAuthentication =
          await googleSignInAccount.authentication.timeout(timeOutLimit);

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await authInstance
          .signInWithCredential(credential)
          .timeout(timeOutLimit);

      final user = authResult.user;

      return Right(user);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      FirebaseCrashlytics.instance
          .log("Error while trying to sign in with google");
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      return Left("Sign in failed");
    }
  }

  Future<Either<String, User>> signInWithCredentials({
    @required String email,
    @required String password,
  }) async {
    try {
      var userCredential = await authInstance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .timeout(timeOutLimit);

      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseExceptionToMessage().get(e.code));
    }
  }

  Future<Either<String, User>> updateUser(
      {String email, String username}) async {
    try {
      if (email != null) {
        await authInstance.currentUser.updateEmail(email).timeout(timeOutLimit);
      }
      if (username != null) {
        await authInstance.currentUser
            .updateDisplayName(username)
            .timeout(timeOutLimit);
      }
      return Right(authInstance.currentUser);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseExceptionToMessage().get(e.code));
    }
  }

  Future<Either<String, User>> getUser() async {
    try {
      final currentUser = await authInstance.currentUser;
      if (currentUser == null) {
        return Left("Unauthenticated");
      }
      return Right(currentUser);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseExceptionToMessage().get(e.code));
    }
  }

  Future<Either> signOut() async {
    try {
      await authInstance.signOut().timeout(timeOutLimit);

      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseExceptionToMessage().get(e.code));
    }
  }

  Future<Either<String, User>> signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login().timeout(timeOutLimit);

      if (result.status != LoginStatus.success) {
        FirebaseCrashlytics.instance.log(
            "Error while trying to sign in with Facebook: ${result.message}");

        //FIX: User explictly cancel the event, so it should not be cactched as Error
        // it more like analytic event
        // FirebaseCrashlytics.instance.recordError(
        //     Exception(jsonEncode(result.message)), StackTrace.current);

        return Left(
            'Login failed or aborted. Please try again or use another login method.');
      }

      final credential =
          FacebookAuthProvider.credential(result.accessToken.token);

      final authResult = await authInstance
          .signInWithCredential(credential)
          .timeout(timeOutLimit);

      final user = authResult.user;

      return Right(user);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      FirebaseCrashlytics.instance
          .log("Error while trying to sign in with Facebook");
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      return Left(
          'Login failed or aborted. Please try again or use another login method.');
    }
  }

  Future<Either<String, User>> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      print(appleCredential.authorizationCode);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final authResult =
          await authInstance.signInWithCredential(oauthCredential);

      final displayName =
          '${appleCredential.givenName} ${appleCredential.familyName}';
      final userEmail = '${appleCredential.email}';

      final firebaseUser = authResult.user;
      await firebaseUser.updateDisplayName(displayName);
      await firebaseUser.updateEmail(userEmail);

      return Right(firebaseUser);
      // ignore: avoid_catches_without_on_clauses
    } catch (exception) {
      FirebaseCrashlytics.instance
          .log("Error while trying to sign in with Facebook");
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      return Left('Please try again or use another login method.');
    }
  }

  Future<Either> resetPassword(String email) async {
    try {
      await authInstance
          .sendPasswordResetEmail(email: email)
          .timeout(timeOutLimit);

      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseExceptionToMessage().get(e.code));
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
