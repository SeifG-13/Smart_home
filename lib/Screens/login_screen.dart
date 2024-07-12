// social auth  (8)

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/Utilities/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushReplacementNamed(
      context,
      MyRoutes.homeScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ) : Material(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
                  children: [
                    Lottie.asset(
                      'assets/animation/Animation - 1720429234245.json',
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Welcome!',
                            textStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.w500,
                            ),
                            speed: const Duration(
                              milliseconds: 450,
                            )),
                      ],
                      onTap: () {
                        debugPrint("Welcome back!");
                      },
                      isRepeatingAnimation: true,
                      totalRepeatCount: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      child: Form(
                        key: formState,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: 'Enter Your Username/Email',
                                labelText: 'Email or Username',
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email';
                                }
                                return null;
                              },
                              controller: email,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: 'Enter Your Password',
                                labelText: 'Password',
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                              controller: password,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, MyRoutes.forgotPassword);
                              },
                              child: const Text(
                                'Forgot Password?',
                              ),
                            ),
                            TextButton.icon(
                              onPressed: (() async {
                                if (formState.currentState!.validate()) {
                                  try {
                                    isLoading = true;
                                    setState(() {});
                                    final credential = await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text,
                                    );
                                    isLoading = false;
                                    setState(() {});
                                    if (credential.user!.emailVerified) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        MyRoutes.homeScreen,
                                      );
                                    } /*else {
                                 AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'pls verifie ur email',
                                  desc: 'check ur email .',
                                ).show();
                              }*/
                                  } on FirebaseAuthException catch (e) {
                                    isLoading = false;
                                    setState(() {});
                                    if (e.code == 'user-not-found') {
                                      print('No user found for that email.');
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.rightSlide,
                                        title: 'Error',
                                        desc: 'No user found for that email.',
                                      ).show();
                                    } else if (e.code == 'wrong-password') {
                                      print(
                                          'Wrong password provided for that user.');
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.rightSlide,
                                        title: 'Error',
                                        desc:
                                            'Wrong password provided for that user.',
                                      ).show();
                                    }
                                    /*AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'No user found for that email.',
                                ).show();*/
                                    print("=========================${e.code}");
                                    // }
                                  }
                                }
                              }),
                              icon: const Icon(Icons.login),
                              label: Container(
                                alignment: Alignment.center,
                                width: 150,
                                height: 35,
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Text('Don\'t have an account?'),
                                TextButton(
                                  onPressed: (() {
                                    Navigator.pushReplacementNamed(
                                        context, MyRoutes.signUp);
                                  }),
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),

                            // social auth

                            TextButton.icon(
                              onPressed: (() {
                                try {
                                  GoogleSignIn();
                                  print('=====================google');
                                } catch (e) {
                                  print(e);
                                }
                              }),
                              icon: const Icon(Icons.chair),
                              label: Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 35,
                                child: const Text(
                                  'Sign In with Google',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
