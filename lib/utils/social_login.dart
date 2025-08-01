import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

class SocialLogin {

  //Twitter
  Future<User?> loginWithTwitter() async {
    final twitterLogin = TwitterLogin(
      // API keys
      apiKey: 'AAZwVIFH3EfbMApqibnEHYMAx',
      // API Secret keys
      apiSecretKey: 'SSq9TWsN9uAg8CpwPTnCUHS9dI57A7RrHqFIIXaQcaKoNXH5K7',

      redirectURI: 'https://developer-testing-25938.firebaseapp.com/__/auth/handler',
    );

      final authResult = await twitterLogin.login();

      if (authResult.status == TwitterLoginStatus.loggedIn) {
        final twitterAuthCredential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken!,
          secret: authResult.authTokenSecret!,
        );

        final userCredential = await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
        return userCredential.user;
      } else {
        throw Exception("Twitter login failed: ${authResult.errorMessage}");
      }
    }


    // Google
  Future<User?> loginWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();

      if (googleSignInAccount == null) {
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await auth.signInWithCredential(
        credential,
      );
      final User? user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);

        final User? currentUser = auth.currentUser;
        assert(user.uid == currentUser!.uid);

        debugPrint('signInWithGoogle succeeded: $user');
        await googleSignIn.signOut();

        return user;
      } else {
        return null;
      }
    } catch (error) {
      debugPrint("G-SignIn error: $error");
      return null;
    }
  }

  // Apple login
  Future<User?> loginInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.example.myFirstApp', // Your Service ID
          redirectUri: Uri.parse(
            'https://developer-testing-25938.firebaseapp.com/__/auth/handler',
          ),
        ),
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return userCredential.user;
    } catch (e,s) {
      print("Apple Sign-In Error: $e");
      FirebaseCrashlytics.instance.recordError(e,s);
      return null;
    }
  }

  // GitHub login
/*  Future<UserCredential> signInWithGitHub() async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: clientId,
        clientSecret: clientSecret,
        redirectUrl: 'https://my-project.firebaseapp.com/__/auth/handler');

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
  }*/


  /*Future<UserData?> loginInWithApple() async {
    final isAvailable = await SignInWithApple.isAvailable();
    final clientState = const Uuid().v4();

    try {
      if (isAvailable) {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'com.example.my_first_app',
            redirectUri: Uri.parse(
              'https://developer-testing-25938.firebaseapp.com/__/auth/handler',
            ),
          ),
          state: clientState,
        );

        final jwt = credential.identityToken;
        if (jwt != null) {
          final result = parseJwt(jwt);
          return UserData(
            email: credential.email ?? result["email"],
            firstName: credential.givenName,
            lastName: credential.familyName,
          );
        }
      } else {
        // Android fallback
        final url = Uri.https('appleid.apple.com', '/auth/authorize', {
          'response_type': 'code id_token',
          'client_id': 'com.example.my_first_app',
          'response_mode': 'form_post',
          'redirect_uri': 'https://developer-testing-25938.firebaseapp.com/__/auth/handler',
          'scope': 'email name',
          'state': clientState,
        });

        final result = await FlutterWebAuth.authenticate(
          url: url.toString(),
          callbackUrlScheme: "com.example.my_first_app",
        );

        final body = Uri.parse(result).queryParameters;
        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: body['id_token'],
          accessToken: body['code'],
        );

        final data = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
        final user = data.user;

        if (user != null) {
          return UserData(
            email: user.email,
            firstName: user.displayName?.split(" ").first,
            lastName: user.displayName?.split(" ").last,
            profileImage: user.photoURL,
          );
        }
      }
    } catch (e) {
      debugPrint("Apple Sign-In Error: $e");
    }

    return null;
  }*/

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    debugPrint("JsonDecode:--------------------");
    debugPrint(payload);
    debugPrint(jsonEncode(payloadMap));

    return payloadMap;
  }
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

String _generateNonce([int length = 32]) {
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

String _sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
