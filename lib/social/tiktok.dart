import 'dart:developer';

import 'package:flutter/services.dart';

class Tiktok {
  static const platform = MethodChannel('social_sharing');

  static share(List<String> file) async {
    try {
      await platform.invokeMethod('shareToTiktok', {'filePaths': file});
    } on PlatformException catch (e, s) {
      log("Failed with error : '${e.message}'. \n $s");
      throw (e, s);
    } catch (e, s) {
      log("Failed with error : '$e'. \n $s");
      throw (e, s);
    }
  }
}