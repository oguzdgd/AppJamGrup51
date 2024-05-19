import 'package:appjamgrup51/app/app.locator.dart';
import 'package:appjamgrup51/app/app.router.dart';
import 'package:appjamgrup51/services/authentication_service.dart';
import 'package:appjamgrup51/ui/main/main_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends MainViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  Future<void> signUp(String email, String password,String confirmpassword, String name, String surname,) async {
    setBusy(true);
    try {
      User? user = await _authenticationService.signUpWithEmailAndPassword(email, password,confirmpassword, name, surname,);
      if (user != null) {
        _navigationService.replaceWithLoginView();
      }
    } catch (e) {
      print('Beklenmedik bir hata oluştu: $e');
    } finally {
      setBusy(false);
    }
  }

  void goToLogin() {
    _navigationService.replaceWithLoginView();
  }
}
