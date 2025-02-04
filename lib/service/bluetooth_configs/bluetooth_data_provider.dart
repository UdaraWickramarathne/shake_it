import 'package:flutter/material.dart';

class BluetoothDataProvider extends ChangeNotifier {
  String _receivedData = '';

  String get receivedData => _receivedData;

  void updateData(String newData) {
    _receivedData = newData;
    notifyListeners();
  }
  
  void clearReceivedData() {
    _receivedData = '';
    notifyListeners();
  }
}
