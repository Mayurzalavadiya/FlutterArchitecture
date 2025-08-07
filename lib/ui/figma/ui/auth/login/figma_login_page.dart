import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/generated/assets.dart';
import 'package:my_first_app/router/app_router.dart';
import 'package:my_first_app/values/export.dart';

@RoutePage()
class FigmaLoginPage extends StatefulWidget {
   const FigmaLoginPage({super.key});

  @override
  State<FigmaLoginPage> createState() => _FigmaLoginPageState();
}

class _FigmaLoginPageState extends State<FigmaLoginPage> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // optional, default is true
      body: Stack(
        children: [
          // 👇 Fullscreen background image
          Image.asset(Assets.imageFigmaImageSplash, width: double.infinity, fit: BoxFit.cover),
          _loginUI(),
        ],
      ),
    );
  }

  Widget _loginUI() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 58.h),
          Image.asset(Assets.imageFigmaLogo, height: 76, width: 213),
          SizedBox(height: 135.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.darkBg.withSafeOpacity(0.7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              border: Border.all(
                color: AppColor.stroke,
                width: 1.w,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
      
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 38.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign in',
                    style: textBold.copyWith(
                      fontSize: 32.sp,
                      color: AppColor.white,
                    ),
                  ),
      
                  SizedBox(height: 24.h),
                  _getSignInForm(),
                  SizedBox(height: 24.h),
                  _socialLogin(),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: textFigtreeBold,
            cursorColor: AppColor.white,
            focusNode: emailFocus,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(passwordFocus),
            decoration: InputDecoration(
              hintText: 'Email',
              fillColor: emailFocus.hasFocus ? AppColor.santasGray : AppColor.santasGray,
              hintStyle:  TextStyle(color: AppColor.text, fontSize: 18),
              contentPadding:  EdgeInsets.symmetric(
                horizontal: 17,
                vertical: 13,
              ),

              enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.stroke),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              border:  OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.stroke),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide(color: AppColor.white, width: 1.0),
              ),
              labelStyle:  TextStyle(
                fontSize: 18,
                fontFamily: Assets.fontsFigtreeRegular,
              ),
            ),
            validator: (_) => null,
          ),
          SizedBox(height: 24.h),
          TextFormField(
            style: textFigtreeBold,
            cursorColor: AppColor.white,
            focusNode: passwordFocus,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).unfocus(),
            decoration:  InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: AppColor.text, fontSize: 18),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 17,
                vertical: 13,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.stroke),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide(color: AppColor.white, width: 1.0),
              ),
              labelStyle: TextStyle(
                fontSize: 18,
                fontFamily: Assets.fontsFigtreeRegular,
              ),
            ),
            validator: (_) => null,
          ),
          SizedBox(height: 16.h),
          Text(
            'Forgot Password?',
            style: textFigtreeRegular.copyWith(color: AppColor.accent),
          ),
          SizedBox(height: 24.h),
          
          GestureDetector(
            onTap: () => context.router.replace(FigmaMainHomeRoute()),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.gradient3,
                    AppColor.gradient2,
                    AppColor.gradient1,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  'Sign in',
                  style: textExtraBold.copyWith(
                    color: AppColor.white,
                    fontFamily: Assets.fontsFigtreeExtraBold,
                    fontSize: 24.spMin,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(height: 1, color: AppColor.white.withSafeOpacity(0.2)),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'or sign in using',
                style: textFigtreeRegular.copyWith(fontSize: 14.spMin),
              ),
            ),
            Expanded(
              child: Divider(height: 1, color: AppColor.white.withSafeOpacity(0.2)),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imageSoc1, height: 60.w, width: 60.w),
            SizedBox(width: 10.w),
            Image.asset(Assets.imageSoc2, height: 60.w, width: 60.w),
            SizedBox(width: 10.w),
            Image.asset(Assets.imageSoc3, height: 60.w, width: 60.w),
          ],
        ),
        SizedBox(height: 24.h),

        RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: textFigtreeRegular.copyWith(fontSize: 14.spMin),
            children: [
              TextSpan(
                text: 'Sign Up',
                style: textBold.copyWith(
                  color: AppColor.accent,
                  fontSize: 14.spMin,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {

                  },
              ),
            ],
          ),
        )

      ],
    );
  }
}
