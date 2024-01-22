import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:why_not/Controller/loginPageController.dart';
import 'package:why_not/Utlils/colors.dart';
import 'package:why_not/View/loginscreens/OTPverification.dart';
import 'package:why_not/View/loginscreens/chooseLangage.dart';
import 'package:why_not/View/loginscreens/loginBgscreen.dart';
import 'package:why_not/constants.dart';

class UserName extends ConsumerWidget {
  bool showFab = false;

  TextEditingController name = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: LoginBgScreen(
        hidejunktext: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              color: Colors.white),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Name",
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Enter name to create profile ",
                      style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                TextFormField(
                                  autofocus: true,
                                  onFieldSubmitted: (value) {
                                    navigatetoNextScreen(context);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Name";
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingAcctionBtn: showFab == false
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: GestureDetector(
                  onTap: () {
                    navigatetoNextScreen(context);
                  },
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppColor().confimBtnColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Submit",
                            style: GoogleFonts.notoSans(
                                fontSize: 16,
                                color: Color(0xff0F0F10),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                ),
              ),
      ),
    );
  }

  void navigatetoNextScreen(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChooseLanguageView()));
    }
  }
}
