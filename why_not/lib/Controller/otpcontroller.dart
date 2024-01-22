import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpController extends ChangeNotifier {
  bool isEmpty = false;
  void alertNotOtpSetted(BuildContext context, bool isEmpty) {
    this.isEmpty = isEmpty;
    notifyListeners();
  }
}

var otpProvider = ChangeNotifierProvider<OtpController>((ref) {
  return OtpController();
});
