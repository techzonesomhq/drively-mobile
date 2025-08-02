import 'package:app/consts/app_consts.dart';
import 'package:app/helpers/snakbar.dart';
import 'package:get/get.dart';

mixin DataCheckerHelper on SnackBarHelper {
  bool checkText({
    required String text,
    bool isEmpty = true,
    bool emailChecker = false,
    required String errorMessage,
  }) {
    if (text.isEmpty) {
      error(errorMessage);
      return false;
    } else if (emailChecker && !_checkEmail(text)) {
      error('enterRightEmailFormatEx'.tr);
      return false;
    }

    return true;
  }

  bool checkTextsMatch({
    required String text1,
    required String text2,
    required String errorMessage,
  }) {
    if (text1 == text2) {
      return true;
    } else {
      error(errorMessage);
      return false;
    }
  }

  void error(String errorMessage) {
    showSnackBar(message: errorMessage, error: true);
  }

  bool checkObject({required dynamic object, required String message}) {
    if (object == null) {
      error(message);
      return false;
    }

    return true;
  }

  bool checkBool({required bool item, required String message}) {
    if (!item) {
      error(message);
      return false;
    }

    return true;
  }

  bool checkList({required List<dynamic> list, required String message}) {
    if (list.isEmpty) {
      error(message);
      return false;
    }

    return true;
  }

  bool _checkEmail(String email) {
    /// Check Email Format
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  bool otpChecker({required String text, int length = AppConsts.OTP_CODE_LENGTH}) {
    if (text.length != length) {
      error('enterVerificationCodeEx'.tr);
      return false;
    }

    return true;
  }
}
