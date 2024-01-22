import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends ChangeNotifier {
  CountryCode code = CountryCode(code: "IN", dialCode: "+91", name: "India");
  late TextEditingController countryCodeController;
  late List<TextEditingController> digitControllers;
  late List<FocusNode> digitFocusNodes;

  LoginController() {
    countryCodeController = TextEditingController();
    digitControllers = List.generate(10, (index) => TextEditingController());
    digitFocusNodes = List.generate(10, (index) => FocusNode());
  }

  getContryCode() {}

  onChangedCode(CountryCode code) {
    this.code = code;
    notifyListeners();
  }

  void moveFocus(BuildContext context, int currentIndex) {
    if (currentIndex < 9) {
      FocusScope.of(context).requestFocus(digitFocusNodes[currentIndex + 1]);
    } else {
      // If this is the last field, handle submission logic here
      // ref.read(loginProvider).submitOTP();
    }
    notifyListeners();
  }
}

var loginProvider = ChangeNotifierProvider<LoginController>((ref) {
  return LoginController();
});
