import 'package:appjamgrup51/app/app.locator.dart';
import 'package:appjamgrup51/app/app.router.dart';
import 'package:appjamgrup51/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService=locator<AuthenticationService>();


  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));


    if (await _authenticationService.userLoggedIn()) {
      // 3. Navigate to HomeView
      _navigationService.replaceWithMainView();
    } else {
      // 4. Or navigate to LoginView
      _navigationService.replaceWithLoginView();
    }
  }
}
