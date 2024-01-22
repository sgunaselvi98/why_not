import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginBgScreen extends StatelessWidget {
  Widget child, floatingAcctionBtn;
  bool? hidejunktext = false;
  LoginBgScreen(
      {required this.child,
      required this.floatingAcctionBtn,
      this.hidejunktext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: const Color(0xff0D0D0D),
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: Image.asset(
                'assets/images/bgimage.png',
              ).image,
            ),
          ),
          child: Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 120,
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "0 changes everything",
                style: GoogleFonts.notoSans(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: hidejunktext == false,
                child: Column(
                  children: [
                    Text(
                      "( 0 junk, 0 ads, 0 influencer )",
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
        floatingActionButton: floatingAcctionBtn);
  }
}
