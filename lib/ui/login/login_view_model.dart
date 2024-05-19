import 'package:appjamgrup51/app/app.locator.dart';
import 'package:appjamgrup51/app/app.router.dart';
import 'package:appjamgrup51/services/authentication_service.dart';
import 'package:appjamgrup51/ui/main/main_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends MainViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  Future<void> signIn( String email, String password) async {
    setBusy(true);
    var user = await _authenticationService.signInWithEmailAndPassword(
        email, password);
    setBusy(false);

    if (user != null) {
      _navigationService.replaceWith(Routes.mainView);
    } else {
      throw("Giriş Başarısız");
    }
  }

  void goToRegister() {
    _navigationService.replaceWithSignUpView();
  }
}
