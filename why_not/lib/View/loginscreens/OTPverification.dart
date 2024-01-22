import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:why_not/Controller/loginPageController.dart';
import 'package:why_not/Controller/otpcontroller.dart';
import 'package:why_not/Utlils/colors.dart';
import 'package:why_not/View/loginscreens/loginBgscreen.dart';
import 'package:why_not/View/loginscreens/userCreation.dart';
import 'package:why_not/constants.dart';

class OTPverficationView extends ConsumerWidget {
  String phoneNumber;
  OTPverficationView({Key? key, required this.phoneNumber}) : super(key: key);

  bool showFab = false;
  final countryPicker = FlCountryCodePicker(
      title: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      "Select Country",
      style: GoogleFonts.openSans(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    ),
  ));
  var isOtpSet = false;

  List<TextEditingController> digitControllers =
      List.generate(10, (index) => TextEditingController());
  List<FocusNode> digitFocusNodes = List.generate(10, (index) => FocusNode());

  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  List<String> _previousTexts = List.filled(10, '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    isOtpSet = ref.watch(otpProvider).isEmpty;

    return LoginBgScreen(
      hidejunktext: true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your mobile number",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter the OTP sent to ${phoneNumber}",
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Visibility(
                  visible: isOtpSet == true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Kindly Enter OTP ",
                      style: GoogleFonts.notoSans(
                        color: Colors.red,
                      ),
                    ),
                  ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...List.generate(4, (index) {
                                  final focusNode = digitFocusNodes[index];

                                  return Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          width: 78,
                                          height: 83,
                                          decoration: ShapeDecoration(
                                            color: isOtpSet == true
                                                ? Colors.white
                                                : Color(0xFFF1F2F3),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1,
                                                  color: isOtpSet == true
                                                      ? Colors.red
                                                      : Color(0xFFE0E0E0)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: TextFormField(
                                            maxLength: 1,
                                            controller: digitControllers[index],
                                            focusNode: focusNode,
                                            autofocus: index == 0,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                    top: 30, left: 30),
                                                counter: SizedBox()),
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff0F0F10)),
                                            onChanged: (value) {
                                              if (_previousTexts[index]
                                                      .isNotEmpty &&
                                                  value.isEmpty &&
                                                  index != 0) {
                                                // Backspace was pressed in the current field
                                                print(
                                                    'Backspace pressed in field $index');

                                                focustoPrev(context, index);
                                              } else {
                                                moveFocus(
                                                    context, index, value);
                                              }
                                              _previousTexts[index] = value;
                                            },
                                            /*  onChanged: (value) {
                                                    if (index < 9) {
                                                      // Move focus to the next field
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              loginController
                                                                      .digitFocusNodes[
                                                                  index + 1]);
                                                    }
                                                  }, */
                                            /*  onChanged: (value) {
                                                      loginController.moveFocus(
                                                          context, index);
                                                    }, */
                                            onFieldSubmitted: (value) {
                                              moveFocus(context, index, value);
                                            },
                                          ),
                                        )),
                                        Container(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ],
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
      floatingAcctionBtn: showFab == false
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Container(
                height: 80,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (digitControllers[0].text.isEmpty ||
                            digitControllers[1].text.isEmpty ||
                            digitControllers[2].text.isEmpty ||
                            digitControllers[3].text.isEmpty) {
                          ref
                              .read(otpProvider.notifier)
                              .alertNotOtpSetted(context, true);
                        } else {
                          movetoNextScreen(context);
                        }
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
                                "Verify",
                                style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    color: Color(0xff0F0F10),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Please enter a valid code!",
                          style: TextStyle(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Resend",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void moveFocus(BuildContext context, int index, String value) {
    if (value.isEmpty && index > 0) {
      // Handle backspace: If the current field is empty, move focus to the previous field
      // digitControllers[index - 1].clear();
      focustoPrev(context, index);
    } else if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(digitFocusNodes[index + 1]);
    } else {
      movetoNextScreen(context);
    }
  }

  void focustoPrev(BuildContext context, int index) {
    FocusScope.of(context).requestFocus(digitFocusNodes[index - 1]);
  }

  void movetoNextScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserName()));
  }
}
