import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:my_first_app/core/db/app_db.dart';
import 'package:my_first_app/data/model/response/login_response.dart';
import 'package:my_first_app/data/model/response/user_profile_response.dart';
import 'package:my_first_app/router/app_router.dart';
import 'package:my_first_app/ui/auth/store/auth_store.dart';
import 'package:my_first_app/ui/home/store/home_store.dart';
import 'package:my_first_app/utils/social_login.dart';
import 'package:my_first_app/values/colors.dart';
import 'package:my_first_app/values/export.dart';
import 'package:my_first_app/widget/show_message.dart';

import '../../core/db/share_pref.dart';
import '../../core/locator/locator.dart';
import '../../data/model/request/login_request_model.dart';
import '../../generated/assets.dart';
import '../../utils/analytics.dart';
import '../../widget/loading_widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  bool _isObscured = true;

  List<ReactionDisposer>? _disposers;

  // late ValueNotifier<bool> showLoading;

  @override
  void initState() {
    super.initState();
    AnalyticsService().logScreenView("LoginScreen");

    _formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    // showLoading = ValueNotifier<bool>(false);

    emailFocus.addListener(() {
      if (emailFocus.hasFocus) {
        print("TextField focused");
      } else {
        print("TextField unfocused");
      }
    });

    addDisposer();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    // showLoading.dispose();
    super.dispose();
  }

  bool validateInputs() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      showMessage("Please enter email");
      emailFocus.requestFocus();
      return false;
    } else if (!isValidEmail(email)) {
      showMessage("Please enter a valid email");
      emailFocus.requestFocus();
      return false;
    }

    if (password.isEmpty) {
      showMessage("Please enter password");
      passwordFocus.requestFocus();
      return false;
    } else if (password.length < 6) {
      showMessage("Password must be at least 6 characters");
      passwordFocus.requestFocus();
      return false;
    }

    return true;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  void addDisposer() {
    _disposers ??= [
      // success reaction
      reaction((_) => authStore.users, (response) {
        if (response?.code == "200") {
          showMessage(response?.message ?? "");
          FirebaseAnalytics.instance.logEvent(
            name: 'login_success',
            parameters: {'method': 'email'},
          );
          context.router.replaceNamed('/home');
          appDB.user = response?.data as LoginResponse;
          appPreferences.isLogin = true;
        }
      }),
      // error reaction
      reaction((_) => authStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          showCustomToast(context, message: errorMessage);
        }
      }),
    ];
  }

  void _login() async {
    if (validateInputs()) {
      // showLoading.value = true;
      FocusScope.of(context).unfocus();

      final request = LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await authStore.getUser(request); // Wait for login

      // showLoading.value = false;

      // if (authStore.users != null && authStore.users?.code == "200") {
      //   debugPrint("User Response: ${authStore.users}");
      //   showMessage(authStore.users?.message ?? "Login successful");

      // context.router.replaceAll([HomeRoute(onSwitchToWidgets: null, notificationCount: null)]);
      /* Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(
              onSwitchToWidgets: null,
              notificationCount: null,
            ),
          ),
          (route) => false, // Remove all routes
        );*/
      // appDB.isLogin = true;
      // } else if (authStore.errorMessage != null) {
      //   showMessage(authStore.errorMessage!);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.brownSugarColor,
      body: Observer(
        builder: (_) {
          return LoadingWidget(
            status: authStore.isLoading,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    getSignInForm(),
                    const SizedBox(height: 24),
                    _socialLogin(),
                    const SizedBox(height: 24),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.white,
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FlutterLogo(size: 100),
          const SizedBox(height: 32),
          Text(
            "Welcome Back",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          TextFormField(
            focusNode: emailFocus,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(passwordFocus),
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: (_) => null,
          ),
          const SizedBox(height: 16),

          TextFormField(
            focusNode: passwordFocus,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            obscureText: _isObscured,
            onFieldSubmitted: (_) => _login(),
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
              border: const OutlineInputBorder(),
            ),
            validator: (_) => null,
          ),
        ],
      ),
    );
  }

  Widget _socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            final user = await locator<SocialLogin>().loginWithGoogle();
            authStore.isLoading = true;
            if (user != null) {
              showMessage("User signed in: ${user.displayName} ${user.email}");
              handleSocialLogin(user, 'Gmail');
            } else {
              showMessage("Google sign-in failed");
            }
          },
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300, // Border color
            ),
            child: ClipOval(
              child: Image.asset(Assets.imageGoogle, width: 50, height: 50),
            ),
          ),
        ),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: () async {
            final user = await locator<SocialLogin>().loginInWithApple();
            if (user != null) {
              handleSocialLogin(user, 'Apple');

              showMessage("User signed in: ${user.email}");
              //
              //   appPreferences.user = UserData().copyWith(
              //     email: user.email,
              //   );
              //
              //   if(!appPreferences.isLogin) {
              //     context.router.replaceAll([HomeRoute(onSwitchToWidgets: null, notificationCount: null)]);
              //     appPreferences.isLogin = true;
              //   }
            } else {
              showMessage("Apple sign-in failed");
            }
          },
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300, // Border color
            ),
            child: ClipOval(
              child: Image.asset(Assets.imageApple, width: 50, height: 50),
            ),
          ),
        ),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: () async {
            final user = await locator<SocialLogin>().loginWithTwitter();
            if (user != null) {
              handleSocialLogin(user, 'Twitter');

              showMessage("User signed in: ${user.email}");
            } else {
              showMessage("Apple sign-in failed");
            }
          },

          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300, // Border color
            ),
            child: ClipOval(
              child: Image.asset(Assets.imageTwitter, width: 50, height: 50),
            ),
          ),
        ),
      ],
    );
  }

  void handleSocialLogin(User firebaseUser, String method) {
    FirebaseAnalytics.instance.logEvent(
      name: 'login_success',
      parameters: {'method': method},
    );

    appPreferences.user = UserData().copyWith(
      email: firebaseUser.email,
      name: firebaseUser.displayName ?? "",
      profileImage: firebaseUser.photoURL ?? "",
    );
    authStore.isLoading = false;

    if (!appPreferences.isLogin) {
      context.router.replaceAll([
        BottomNavRoute()
      ]);
      appPreferences.isLogin = true;
    }
  }
}
