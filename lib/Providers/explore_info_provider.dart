import 'package:flutter/material.dart';

class ExploreInfoProvider extends ChangeNotifier {
  bool saveInfo = false;

  void saveInfoData() async {
    saveInfo = true;
    notifyListeners();
  }
}
