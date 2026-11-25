
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

class AuthState extends ChangeNotifier {
  String? _token;

  bool get isAuthenticated => _token != null;
  String? get token => _token;

  Future<void> login(String username, String password) async {
    _token = await ApiClient.obtainToken(username, password);
    notifyListeners();
  }

  Future<void> logout() async {
    if (_token != null) {
      await ApiClient.logout(_token!);
      _token = null;
      notifyListeners();
    }
  }
}
