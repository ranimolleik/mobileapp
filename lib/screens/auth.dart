import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  void login(String email) {
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners(); // Notify all listeners to rebuild UI
  }

  void logout() {
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners(); // Notify all listeners to rebuild UI
  }
}
