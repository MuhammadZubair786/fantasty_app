// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasyapp/screens/flix_home_screen.dart';
import 'package:fantasyapp/screens/flix_signin.dart';
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

class SignUpScreen extends StatefulWidget {
  static String tag = '/SignUpScreen';

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  FocusNode passFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode nameFocus = FocusNode();

  FocusNode confirmPasswordFocus = FocusNode();
  TextEditingController _controller = TextEditingController();
  String? email;
  String? password;
  bool autoValidate = false;
  bool passwordVisible = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  showLoading(bool show) {
    setState(
      () {
        isLoading = show;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(
      muvi_navigationBackground,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    );
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

  createAccount() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();

    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    if (name.isEmpty) {
      showSnackBar("Error", "Enter User Name", true, context);
    } else if (email.isEmpty) {
      showSnackBar("Error", "Enter Email Address", true, context);
    } else if (password.isEmpty) {
      showSnackBar("Error", "Enter Password", true, context);
    } else if (confirmPassword.isEmpty) {
      showSnackBar("Error", "Enter confirm Password", true, context);
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#]).{8,}$')
        .hasMatch(password)) {
      showSnackBar(
        "Error",
        "Password must be at least 8 characters long, include uppercase, lowercase, number, and special character.",
        true,
        context,
      );
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#]).{8,}$')
        .hasMatch(confirmPassword)) {
      showSnackBar(
        "Error",
        "Password must be at least 8 characters long, include uppercase, lowercase, number, and special character.",
        true,
        context,
      );
    } else if (password != confirmPassword) {
      showSnackBar("Error", "Passwords do not match", true, context);
      return;
    } else {
      try {
        showLoading(true);
        var userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = userCredential.user!.uid;

        // Store additional user information in Firestore
        await _firestore.collection('users').doc(uid).set({
          'uid': uid,
          'email': email,
          'fullName': name,
          'createdAt': FieldValue.serverTimestamp(),
        });
       
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', email);
        showLoading(false);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
             showSnackBar(
            "Success", "Account created successfully!", false, context);
        
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });

        String errorMessage;
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage =
                'The email address is already in use by another account.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'weak-password':
            errorMessage =
                'The password is too weak. Please choose a stronger password.';
            break;
          case 'operation-not-allowed':
            errorMessage =
                'This operation is not allowed. Please contact support.';
            break;
          default:
            errorMessage = e.message ?? 'An unknown error occurred.';
        }

        // ignore: use_build_context_synchronously
        showSnackBar("Error", errorMessage, true, context);
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar("Error", e.toString(), true, context);
        showLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var form = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: nameController,
            cursorColor: muvi_colorPrimary,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
           
            textInputAction: TextInputAction.next,
            focusNode: nameFocus,
            onFieldSubmitted: (arg) {
              FocusScope.of(context).requestFocus(emailFocus);
            },
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: muvi_colorPrimary)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: muvi_textColorPrimary)),
              labelText: "Name",
              labelStyle:
                  TextStyle(fontSize: ts_normal, color: muvi_textColorPrimary),
              suffixIcon:
                  Icon(Icons.person, color: muvi_colorPrimary, size: 20),
              contentPadding: EdgeInsets.only(bottom: 1.5),
            ),
            style: const TextStyle(
                fontSize: ts_normal,
                color: muvi_textColorPrimary,
                fontFamily: font_regular),
          ).paddingBottom(spacing_standard_new),
          TextFormField(
            controller: emailController,
            cursorColor: muvi_colorPrimary,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            onSaved: (String? value) {
              email = value;
            },
            textInputAction: TextInputAction.next,
            focusNode: emailFocus,
            onFieldSubmitted: (arg) {
              FocusScope.of(context).requestFocus(passFocus);
            },
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: muvi_colorPrimary)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: muvi_textColorPrimary)),
              labelText: "Email",
              labelStyle:
                  TextStyle(fontSize: ts_normal, color: muvi_textColorPrimary),
              suffixIcon:
                  Icon(Icons.mail_outline, color: muvi_colorPrimary, size: 20),
              contentPadding: EdgeInsets.only(bottom: 1.5),
            ),
            style: const TextStyle(
                fontSize: ts_normal,
                color: muvi_textColorPrimary,
                fontFamily: font_regular),
          ).paddingBottom(spacing_standard_new),
          TextFormField(
            controller: passwordController,
            obscureText: passwordVisible,
            cursorColor: muvi_colorPrimary,
            style: const TextStyle(
                fontSize: ts_normal,
                color: muvi_textColorPrimary,
                fontFamily: font_regular),
            focusNode: passFocus,
            onSaved: (String? value) {
              password = value;
            },
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: muvi_colorPrimary)),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: muvi_textColorPrimary)),
              labelText: "Password",
              labelStyle:
                  TextStyle(fontSize: ts_normal, color: muvi_textColorPrimary),
              contentPadding: EdgeInsets.only(bottom: 1.5),
              suffixIcon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: muvi_colorPrimary,
                size: 20,
              ).onTap(
                () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
            ),
          ).paddingBottom(spacing_standard_new),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: passwordVisible,
            cursorColor: muvi_colorPrimary,
            style: TextStyle(
                fontSize: ts_normal,
                color: muvi_textColorPrimary,
                fontFamily: font_regular),
            focusNode: confirmPasswordFocus,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (arg) {
              FocusScope.of(context).requestFocus(passFocus);
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: muvi_colorPrimary)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: muvi_textColorPrimary)),
              labelText: "Confirm Password",
              labelStyle:
                  TextStyle(fontSize: ts_normal, color: muvi_textColorPrimary),
              contentPadding:
                  EdgeInsets.only(bottom: 1.5, top: spacing_control),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                child: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: muvi_colorPrimary,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    var signUpButton = SizedBox(
        width: double.infinity,
        child: isLoading == false
            ? button(
                context,
                "Sign Up",
                () {
                  createAccount();
                },
              )
            : loadingButton(context));

    Widget loginWithGoogle = iconButton(
      context,
      "Sign Up with Google",
      ic_google,
      () {},
      backgroundColor: Colors.white,
    ).paddingOnly(left: spacing_standard_new, right: spacing_standard_new);

    return SafeArea(
      child: Scaffold(
        backgroundColor: muvi_appBackground,
        appBar: appBarLayout(context, "Register", darkBackground: false),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: flixTitle(context).paddingAll(spacing_large)),
              Text(
                "Sign up to discover all our movies and enjoy our features",
                style: primaryTextStyle(color: muvi_textColorPrimary),
                maxLines: 2,
                textAlign: TextAlign.center,
              )
                  .paddingOnly(
                      top: spacing_control,
                      left: spacing_large,
                      right: spacing_large)
                  .center(),
              form.paddingOnly(
                  left: spacing_standard_new,
                  right: spacing_standard_new,
                  top: spacing_large),
              signUpButton.paddingOnly(
                  left: spacing_standard_new,
                  right: spacing_standard_new,
                  top: spacing_large),
              Align(
                  alignment: Alignment.center,
                  child: text(
                    "Or simply sign up with",
                    fontSize: ts_medium,
                  ).paddingAll(spacing_standard_new)),
              loginWithGoogle
                ..paddingOnly(
                    left: spacing_standard_new, right: spacing_standard_new),
              Container(
                margin: EdgeInsets.all(spacing_standard_new),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      16.height,
                      text(
                        "Already have an account?",
                        fontSize: ts_medium,
                        textColor: muvi_textColorPrimary,
                      ).paddingAll(spacing_control),
                      text(
                        "Login",
                        fontSize: ts_medium,
                        fontFamily: font_medium,
                        textColor: muvi_colorPrimary,
                      ).paddingAll(spacing_control).onTap(
                        () {
                          finish(context);
                        },
                      )
                    ],
                  ).onTap(() {
                    SignUpScreen().launch(context);
                  }),
                ),
              ),
              // loadingWidgetMaker().visible(isLoading).center()
            ],
          ),
        ),
      ),
    );
  }
}
