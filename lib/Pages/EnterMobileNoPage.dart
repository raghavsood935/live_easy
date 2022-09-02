import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_liveeasy/Auth/Authentication.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'EnterOTPPage.dart';

class EnterMobileNumber extends StatefulWidget {
  @override
  State<EnterMobileNumber> createState() => _EnterMobileNumberState();
}

class _EnterMobileNumberState extends State<EnterMobileNumber> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final mobNoController = TextEditingController();
  Auth authClass = Auth();
  String verificationIdFinal = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please Enter Your Mobile Number",
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
              "You'll receive a 6 digit code",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Center(
              child: Text(
                "to verify next",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                height: 50,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "images/flag.jpg",
                      height: 35,
                      width: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "+ 91  - ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: 200,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: mobNoController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "Mobile Number",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == "") {
                              Fluttertoast.showToast(
                                  msg: "Enter Mobile Number");
                            } else if (value.toString().length < 10) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Mobile Number can't be less than 10 digits");
                            } else {
                              mobNoController.text = value.toString();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
                    if (formKey.currentState!.validate()) {
                      if (mobNoController.text.length == 10) {
                        setState(() {
                          isLoading = !isLoading;
                          if (isLoading == true) {
                            Fluttertoast.showToast(
                                msg: "Please Wait Sending OTP");
                          }
                        });
                        isLoading == true
                            ? await authClass.verifyPhoneNumber(
                                "+91 ${mobNoController.text}",
                                context,
                                setData,
                              )
                            : Container();
                      }
                    }
                  },
                  child: !isLoading
                      ? Text(
                          "CONTINUE",
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

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
  }
}
