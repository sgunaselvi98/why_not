import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:why_not/Controller/loginPageController.dart';
import 'package:why_not/Utlils/colors.dart';
import 'package:why_not/View/loginscreens/OTPverification.dart';
import 'package:why_not/View/loginscreens/loginBgscreen.dart';
import 'package:why_not/constants.dart';

class LoginView extends ConsumerWidget {
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

  List<TextEditingController> digitControllers =
      List.generate(10, (index) => TextEditingController());
  List<FocusNode> digitFocusNodes = List.generate(10, (index) => FocusNode());

  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  List<String> _previousTexts = List.filled(10, '');

  StringBuffer phoneNumber = StringBuffer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    var code = ref.watch(loginProvider).code;
    final loginController = ref.read(loginProvider);

    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();

        return Future.value(false);
      },
      child: LoginBgScreen(
        hidejunktext: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30),
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
                    "Enter valid mobile number for 4 digit OTP",
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Country Code",
                              style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            Expanded(
                                child: Container(
                              child: InkWell(
                                onTap: () async {
                                  final code = await countryPicker.showPicker(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      context: context);
                                  if (code != null) {
                                    ref.read(loginProvider).onChangedCode(code);
                                  }
                                  print("code is ${code!.dialCode}");
                                },
                                child: Center(
                                    child: Container(
                                        child: Row(
                                  children: [
                                    Text("${code.dialCode}"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ))),
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mobile Number",
                                style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ...List.generate(10, (index) {
                                    final focusNode = digitFocusNodes[index];

                                    return Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: TextFormField(
                                            maxLength: 1,
                                            controller: digitControllers[index],
                                            focusNode: focusNode,
                                            autofocus: index == 0,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                counter: SizedBox()),
                                            onChanged: (value) {
                                              if (_previousTexts[index]
                                                      .isNotEmpty &&
                                                  value.isEmpty &&
                                                  index != 0) {
                                                // Backspace was pressed in the current field
                                                print(
                                                    'Backspace pressed in field $index');

                                                focustoPrev(
                                                  context,
                                                  index,
                                                );
                                              } else {
                                                moveFocus(context, index, value,
                                                    code.dialCode);
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
                                              moveFocus(context, index, value,
                                                  code.dialCode);
                                            },
                                          )),
                                          Container(
                                            width: 10,
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
                child: GestureDetector(
                  onTap: () {
                    validatePhoneNumber(context, code);
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
                            "Confim",
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

  void moveFocus(BuildContext context, int index, String value, var code) {
    if (value.isEmpty && index > 0) {
      // Handle backspace: If the current field is empty, move focus to the previous field
      // digitControllers[index - 1].clear();
      focustoPrev(context, index);
    } else if (value.isNotEmpty && index < 9) {
      FocusScope.of(context).requestFocus(digitFocusNodes[index + 1]);
    } else {
      validatePhoneNumber(context, code);
      show_log_error("the phoneNumber is $phoneNumber");
    }
  }

  void focustoPrev(BuildContext context, int index) {
    FocusScope.of(context).requestFocus(digitFocusNodes[index - 1]);
  }

  void validatePhoneNumber(BuildContext context, var code) {
    StringBuffer phoneNumbercode = StringBuffer();
    phoneNumber = StringBuffer();
    phoneNumbercode.write('${code} ');
    for (var data in digitControllers) {
      phoneNumber.write(data.text);
    }
    if (phoneNumber.toString() != "") {
      phoneNumbercode.write(phoneNumber);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OTPverficationView(phoneNumber: phoneNumbercode.toString())));
    } else {
      const snackBar = SnackBar(
        content: Text('Check Phone Number'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
