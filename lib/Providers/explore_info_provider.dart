import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExploreInfoProvider extends ChangeNotifier {
  bool saveInfo = false;

  void saveInfoData() async {
    saveInfo = true;
    notifyListeners();
  }
}
