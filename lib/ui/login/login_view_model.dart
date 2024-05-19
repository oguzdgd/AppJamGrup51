import 'dart:async';

import 'package:appjamgrup51/app/app.locator.dart';
import 'package:appjamgrup51/app/app.router.dart';
import 'package:appjamgrup51/services/authentication_service.dart';
import 'package:appjamgrup51/ui/main/main_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends MainViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  static const int snackbarDuration = 2000; // 2 saniye örnek olarak

  Future<void> signIn( String email, String password) async {
    setBusy(true);
    try {
      User? user = await _authenticationService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        _navigationService.replaceWithMainView();
      }
    } catch (e) {
      print('Beklenmedik bir hata oluştu: $e');
    } finally {
      setBusy(false);
    }
  }

  void goToRegister() {
    _navigationService.replaceWithSignUpView();
  }
}
