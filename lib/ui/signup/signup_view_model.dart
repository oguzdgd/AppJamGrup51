import 'package:appjamgrup51/app/app.locator.dart';
import 'package:appjamgrup51/app/app.router.dart';
import 'package:appjamgrup51/services/authentication_service.dart';
import 'package:appjamgrup51/ui/main/main_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends MainViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();


  Future<void> signUp(String email, String password) async {
    try {
      await _authenticationService.signUpWithEmailAndPassword(email, password);
      _navigationService.replaceWithLoginView();
      // Başarılı bir şekilde kayıt olduktan sonra istediğiniz işlemleri yapabilirsiniz.
    } catch (e) {
      // Hata durumunda burada bir işlem yapabilirsiniz, örneğin kullanıcıya bir hata mesajı gösterebilirsiniz.
      print(e);
    }
  }

  void goToLogin() {
    _navigationService.replaceWithLoginView();
  }
}
