import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math';

class RotatingSliderWidget extends StatefulWidget {
  const RotatingSliderWidget({Key? key}) : super(key: key);

  @override
  State<RotatingSliderWidget> createState() => _RotatingSliderWidgetState();
}

class _RotatingSliderWidgetState extends State<RotatingSliderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      upperBound: pi * 2,
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  ContentModel? center;

  final GlobalKey _draggableKey = GlobalKey();

  _center(ContentModel index) {
    setState(() {
      center = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Color(0xffF4FAFF),
      // drawer: const Drawer(),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.asset(
                'assets/images/microappsbg.png',
              ).image),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 27.82,
                      height: 27.83,
                      child: Icon(FluentIcons.dark_theme_24_regular),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: Icon(
                          Icons.language_outlined,
                          size: 30,
                          color: Color.fromARGB(255, 208, 208, 208),
                        ),
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 39,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://randomuser.me/api/portraits/men/40.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
              width: 191,
              height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'dump the junk',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'Noto Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/images/HappsLogo.png")
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                center = null;
                              });
                            },
                            icon: Icon(Icons.refresh),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff7DFF53)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Stack(
                    alignment: AlignmentDirectional(0, 0),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 40),
                                  child: getRoundedBTn(
                                      "photos", "assets/images/photos.png",
                                      onPressed: () {}),
                                ),
                                DragTarget(
                                  builder:
                                      (context, candidateData, rejectedData) {
                                    return center == null
                                        ? Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 80),
                                            child: Column(
                                              children: [
                                                DottedBorder(
                                                    borderType:
                                                        BorderType.Circle,
                                                    dashPattern: const [5, 10],
                                                    color: Color(0xFF9AA5B6),
                                                    child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: Center(
                                                          child: Text(
                                                        "0 \nJunks",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF9AA5B6),
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Noto Sans',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Drag and drop",
                                                  style: TextStyle(
                                                    color: Color(0xFF667085),
                                                    fontSize: 12,
                                                    fontFamily: 'Noto Sans',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 80),
                                            child: getRoundedBTncenter(
                                                center!.index, center!.image,
                                                onPressed: () {}),
                                          );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                getRoundedBTn("mail", "assets/images/mail.png",
                                    onPressed: () {}),
                                SizedBox(
                                  height: 20,
                                ),
                                getRoundedBTn("post", "assets/images/posts.png",
                                    onPressed: () {}),
                              ],
                            ),
                            Column(
                              children: [
                                getRoundedBTn(
                                    "chats", "assets/images/chats.png",
                                    onPressed: () {}),
                                SizedBox(
                                  height: 20,
                                ),
                                getRoundedBTn("apps", "assets/images/apps.png",
                                    onPressed: () {}),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffF4FAFF),
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              BottomIcon(FluentIcons.home_32_filled, true, "Home"),
              BottomIcon(FluentIcons.search_32_regular, false, "Search"),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
              BottomIcon(FluentIcons.chat_32_regular, false, "Team"),
              BottomIcon(FluentIcons.settings_32_regular, false, "Search"),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(-0.84, -0.54),
            end: Alignment(0.84, 0.54),
            colors: [Color(0xFF5A3EDC), Color(0xFF9C88FF)],
          ),
        ),
        child: Container(
          // onPressed: () {},
          child: Center(
            child: Image.asset(
              "assets/images/send.png",
              height: 40,
              width: 40,
            ),
          ),
          // elevation: 5.0,
        ),
      ),
    );
  }

  getRoundedBTn(String s, String t, {required Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: LongPressDraggable(
        onDragEnd: (details) {
          _center(
              ContentModel(index: s, backgroundColor: Colors.red, image: t));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewScreen(title: s)));
        },
        feedback: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.60,
                child: Text(
                  s,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 12,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 60,
                height: 60,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x23627D90),
                        blurRadius: 23.59,
                        offset: Offset(0, 5.90),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 25,
                      height: 25,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Image.asset(
                        t,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.60,
                child: Text(
                  s,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 12,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 60,
                height: 60,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x23627D90),
                        blurRadius: 23.59,
                        offset: Offset(0, 5.90),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 25,
                      height: 25,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Image.asset(
                        t,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getRoundedBTncenter(String s, String t, {required Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 100,
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.60,
              child: Text(
                s,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF667085),
                  fontSize: 12,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 80,
              height: 80,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x23627D90),
                      blurRadius: 23.59,
                      offset: Offset(0, 5.90),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      t,
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

  BottomIcon(IconData home, bool first, var t) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: first,
          child: Container(
            width: 50,
            height: 2,
            decoration: ShapeDecoration(
              color: Color(0xFF7059DE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Icon(home),
            SizedBox(
              height: 5,
            ),
            Text(
              t,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF101828),
                fontSize: 12,
                fontFamily: 'Noto Sans',
                fontWeight: first == true ? FontWeight.w500 : FontWeight.normal,
                height: 0,
                letterSpacing: -0.18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContentModel {
  final String index;
  final String image;
  final Color backgroundColor;

  ContentModel(
      {required this.index,
      required this.backgroundColor,
      required this.image});
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoProvider,
  });

  final GlobalKey dragKey;
  final ImageProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 150,
          width: 150,
          child: Opacity(
            opacity: 0.85,
            child: Image(
              image: photoProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  String title;
  NewScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${this.title}"),
      ),
    );
  }
}
