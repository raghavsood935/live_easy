import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_liveeasy/Pages/LanguageSelectionPage.dart';
import 'package:flutter_liveeasy/Pages/ProfileSelectionPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Pages/EnterOTPPage.dart';

// All Firebase Auth Functions Are Here
class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();

  void storeTokenAndData(UserCredential userCredential) async {
    print("Storing token and data");
    await storage.write(
      key: "Token",
      value: userCredential.credential!.token.toString(),
    );
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      Fluttertoast.showToast(msg: "Enter The Received OTP ");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      Fluttertoast.showToast(msg: "Invalid Mobile Number !");
    };
    void Function(String verificationID, [int? forceResnedingtoken]) codeSent =
        (String verificationID, [int? forceResnedingtoken]) {
      setData(verificationID);
      print('Id is $verificationID');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EnterOTP(
            phoneNumber: phoneNumber,
            verificationIdfinal: verificationID,
          ),
        ),
      );
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      Fluttertoast.showToast(msg: "Request Time Out");
    };
    try {
      await auth.verifyPhoneNumber(
          timeout: Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => ProfileSelection()),
          (route) => false);

      Fluttertoast.showToast(msg: "You're Now Logged In");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
