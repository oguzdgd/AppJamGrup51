import 'package:appjamgrup51/app/app.locator.dart';
import 'package:appjamgrup51/app/app.router.dart';
import 'package:appjamgrup51/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService=locator<AuthenticationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    if (await _authenticationService.userLoggedIn()) {
      // 3. Navigate to HomeView
      _navigationService.replaceWith(Routes.mainView);
    } else {
      // 4. Or navigate to LoginView
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
