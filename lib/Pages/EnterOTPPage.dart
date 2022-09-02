import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_liveeasy/Pages/LanguageSelectionPage.dart';
import 'package:flutter_liveeasy/Pages/ProfileSelectionPage.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../Auth/Authentication.dart';

class EnterOTP extends StatefulWidget {
  String? phoneNumber;
  String? verificationIdfinal;
  EnterOTP({required this.phoneNumber, required this.verificationIdfinal});

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  Auth authClass = Auth();
  String? smsCode;
  final controller = TextEditingController();
  bool isLoading = false;

  String _comingSms = 'Unknown';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.phoneNumber);
    initSmsListener();
  }

  Future<void> initSmsListener() async {
    String comingSms;
    try {
      comingSms = (await AltSmsAutofill().listenForSms)!;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms;
      print("====>Message: ${_comingSms}");
      print("${_comingSms[32]}");
      controller.text = _comingSms[0] +
          _comingSms[1] +
          _comingSms[2] +
          _comingSms[3] +
          _comingSms[4] +
          _comingSms[5];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verify Phone",
              style: TextStyle(
                fontSize: 19,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Code is sent to ${widget.phoneNumber}",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: PinCodeTextField(
                controller: controller,
                maxLength: 6,
                pinBoxHeight: 50,
                pinBoxWidth: 50,
                pinBoxColor: Color(
                  0xff93D2F3,
                ),
                defaultBorderColor: Color(
                  0xff93D2F3,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: "Didn't received the Code ? ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "Request again",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 500,
                height: 45,
                child: MaterialButton(
                  color: Color(
                    0xff2E3B62,
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await authClass.signInwithPhoneNumber(
                        widget.verificationIdfinal!, controller.text, context);
                  },
                  child: !isLoading
                      ? Text(
                          "VERIFY AND CONTINUE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(
                          height: 20,
                          width: 20,
                          color: Colors.transparent,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.5,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }
}
