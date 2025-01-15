// ignore_for_file: non_constant_identifier_names

import 'package:fantasyapp/screens/flix_home_screen.dart';
import 'package:fantasyapp/screens/flix_signup.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:fantasyapp/utils/flix_constants.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_images.dart';
import 'package:fantasyapp/utils/resources/flix_size.dart';
import 'package:fantasyapp/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatefulWidget {
  static String tag = '/SignInScreen';

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  FocusNode passFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;
  bool autoValidate = false;
  bool passwordVisible = false;
  bool isLoading = false;

  showLoading(bool show) {
    setState(() {
      isLoading = show;
    });
  }

  @override
  void initState() {
    setStatusBarColor(
      muvi_navigationBackground,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    );

    super.initState();
  }

    LoginAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      showSnackBar("Error", "Enter Email Address", true, context);
    } else if (password.isEmpty) {
      showSnackBar("Error", "Enter Password", true, context);
    }  else {
      try {
        showLoading(true);
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
         final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', email);
               showLoading(false);

        showSnackBar("Success", "Account login successfully!", false, context);
        doSignIn(context);
        showLoading(false);
      }
      on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak. Please choose a stronger password.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'This operation is not allowed. Please contact support.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown error occurred.';
      }

      // ignore: use_build_context_synchronously
      showSnackBar("Error", errorMessage, true, context);
    } 
      
       catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar("Error", e.toString() , true, context);
        showLoading(false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var form = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        formField(
          
          context,
          "Email",
          maxLine: 1,
          keyboardType: TextInputType.emailAddress,
          onSaved: (String? value) {
            email = value;
          },
          controller: emailController,
          textInputAction: TextInputAction.next,
          focusNode: emailFocus,
          nextFocus: passFocus,
          suffixIcon: Icons.mail_outline,
        ).paddingBottom(spacing_standard_new),
        formField(
          controller: passwordController,
          context,
          "Password",
          isPassword: true,
          isPasswordVisible: passwordVisible,
          focusNode: passFocus,
          onSaved: (String? value) {
            password = value;
          },
          textInputAction: TextInputAction.done,
          suffixIconSelector: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
          suffixIcon: passwordVisible ? Icons.visibility : Icons.visibility_off,
        )
      ],
    );
    var signinButton = SizedBox(
      width: double.infinity,
      child: isLoading == false ? button(context, "Get Started", () {
        // doSignIn(context);
        LoginAccount();
      }):loadingButton(context),
    );
    var loginWithGoogle = iconButton(
      context,
      "Login with Google",
      ic_google,
      () {},
      backgroundColor: Colors.white,
    ).paddingOnly(left: spacing_standard_new, right: spacing_standard_new);

    return SafeArea(
      child: Scaffold(
        backgroundColor: muvi_appBackground,
        appBar: appBarLayout(context, "Login", darkBackground: false),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: flixTitle(context).paddingAll(spacing_large)),
                  text(
                    "Please Login to enjoy more benefits and we won't let you go",
                    fontSize: ts_normal,
                    textColor: muvi_textColorPrimary,
                    maxLine: 2,
                    isCentered: true,
                  ).paddingOnly(
                      top: spacing_control,
                      left: spacing_large,
                      right: spacing_large),
                  form.paddingOnly(
                      left: spacing_standard_new,
                      right: spacing_standard_new,
                      top: spacing_large),
                  text(
                    "Forgot Password",
                    fontSize: ts_medium,
                    textColor: muvi_colorPrimary,
                  ).paddingAll(spacing_standard_new).onTap(() {
                    onForgotPasswordClicked(context);
                  }),
                  signinButton.paddingOnly(
                      left: spacing_standard_new, right: spacing_standard_new),
                  Container(
                    // margin: EdgeInsets.all(spacing_standard_new),
                    // height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        text(
                          "Don't have an account?",
                          fontSize: ts_medium,
                          textColor: muvi_textColorPrimary,
                        ).paddingAll(spacing_control),
                        text(
                          "Register",
                          fontSize: ts_medium,
                          fontFamily: font_medium,
                          textColor: muvi_colorPrimary,
                        ).paddingAll(spacing_control).onTap(
                          () {
                            SignUpScreen().launch(context);
                          },
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: text(
                        "Or simply login with",
                        fontSize: ts_medium,
                      ).paddingAll(spacing_standard_new)),
                  loginWithGoogle
                    ..paddingOnly(
                        left: spacing_standard_new,
                        right: spacing_standard_new),
                ],
              ),
            ),
            // Center(child: loadingWidgetMaker().visible(isLoading))
          ],
        ),
      ),
    );
  }

  onForgotPasswordClicked(context) {}

  doSignIn(context) {
    finish(context);
    HomeScreen().launch(context);
  }
}
