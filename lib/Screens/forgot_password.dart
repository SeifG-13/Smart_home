
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/Utilities/routes.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Lottie.asset(
              'assets/animation/Animation - forget.json',
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 35,
              width: 30,
            ),
            const Center(
              child: Text(
                'Send Reset Link to Email!',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Email',
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    controller: email,
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  TextButton.icon(
                    onPressed: (()async {
                      if ( email.text == ""){
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'No email written.',
                        ).show();
                        return;
                      }
                      try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'alright',
                            desc: 'check ur email.',
                          ).show();
                      }
                      catch(e){
                          print(e);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'error',
                            desc: 'this email doesn\'t exist.',
                          ).show();
                      }
                    }),
                    icon: const Icon(
                      Icons.read_more,
                      size: 28,
                    ),
                    label: Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 35,
                      child: const Text(
                        'Send Reset Link',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  TextButton.icon(
                    onPressed: (() {
                      Navigator.pushReplacementNamed(context, MyRoutes.loginScreen);
                    }),
                    icon: const Icon(
                      Icons.home,
                      size: 28,
                    ),
                    label: Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 35,
                      child: const Text(
                        'Return Home',
                        style: TextStyle(
                          fontSize: 12,
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
          ],
        ),
      ),
    );
  }
}
