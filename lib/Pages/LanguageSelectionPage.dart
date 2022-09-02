import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_liveeasy/Pages/EnterMobileNoPage.dart';

class SelectLanguage extends StatefulWidget {
  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  String dropDownValue = "English";
  var items = ["English", "Hindi"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.photo,
                size: 60,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Please Select Your Language",
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
                "You can change the language",
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
                  "at any time",
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
              Container(
                width: 170,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                    ),
                    value: dropDownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropDownValue = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 170,
                height: 45,
                child: MaterialButton(
                  color: Color(
                    0xff2E3B62,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnterMobileNumber()),
                    );
                  },
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            child: Image.asset(
              "images/image2.png",
              fit: BoxFit.cover,
            ),
            left: 0,
            bottom: 0,
            right: 0,
          ),
          Positioned(
            child: Image.asset(
              "images/image.png",
              fit: BoxFit.cover,
            ),
            left: 0,
            bottom: 0,
            right: 0,
          )
        ],
      ),
    );
  }
}
