import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:why_not/Controller/loginPageController.dart';
import 'package:why_not/Utlils/colors.dart';
import 'package:why_not/View/loginscreens/OTPverification.dart';
import 'package:why_not/View/loginscreens/loginBgscreen.dart';
import 'package:why_not/constants.dart';

class ChooseLanguageView extends ConsumerWidget {
  bool showFab = false;

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    List<LangageModel> mList = [
      LangageModel("English", "english"),
      LangageModel("Hindi", "हिंदी"),
      LangageModel("Telgu", "తెలుగు"),
      LangageModel("Tamil", "தமிழ்"),
    ];

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
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.language,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Choose Language",
                        style: GoogleFonts.openSans(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "System Default : ",
                            style: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "India | english",
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      ...List.generate(mList.length, (index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${mList[index].name}",
                                  style: GoogleFonts.openSans(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${mList[index].localName}",
                                  style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  )
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
                          "Confirm",
                          style: GoogleFonts.notoSans(
                              fontSize: 16,
                              color: Color(0xff0F0F10),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
              ),
      ),
    );
  }
}

class LangageModel {
  String? name, localName;
  LangageModel(this.name, this.localName);
}
