import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:book_donation/Screens/home_screen.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import '../router/route_constants.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/verify1.png',
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            'Verify your email before continuing !!',
            style: TextStyle(
              height: 1.1,
              fontWeight: FontWeight.bold,
              fontSize: 26,
              fontFamily: "Jua",
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'We have sent a mail to ${user.email}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.1,
              fontSize: 20,
              fontFamily: "Jua",
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          MaterialButton(
            onPressed: checkEmailVerified,
            height: 60,
            minWidth: 200,
            color: const Color(0xff00B0FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 0, left: 50, right: 50),
              child: Text(
                'CONTINUE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  fontFamily: "Jua",
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
                cornerRadius: 20.0,
                image: Image.asset('assets/images/verified.webp'),
                title: Text(
                  'Successfully Verified',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.black,
                      fontFamily: "Jua"),
                ),
                description: Text(
                  user.email,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Jua",
                  ),
                ),
                entryAnimation: EntryAnimation.BOTTOM,
                onlyOkButton: true,
                buttonOkColor: Color(0xff00B0FF),
                buttonOkText: Text(
                  "CONTINUE",
                  style: TextStyle(fontFamily: "Jua", color: Colors.white),
                ),
                onOkButtonPressed: () {
                  Navigator.pushNamed(context, homeRoute);
                },
              ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You haven't Verified your email yet"),
        ),
      );
    }
  }
}
