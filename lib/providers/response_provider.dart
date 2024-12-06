import 'package:flutter/foundation.dart';

class ResponseProvider with ChangeNotifier {
  String _currentResponse = '';
  
  String get currentResponse => _currentResponse;

  void setResponse(String response) {
    _currentResponse = response;
    notifyListeners();
  }
}