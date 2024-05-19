import 'package:appjamgrup51/services/authentication_service.dart';
import 'package:appjamgrup51/ui/login/login_view.dart';
import 'package:appjamgrup51/ui/main/main_view.dart';
import 'package:appjamgrup51/ui/signup/signup_view.dart';
import 'package:appjamgrup51/ui/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
    routes: [

      MaterialRoute(page: SplashView, initial: true),
      MaterialRoute(page: MainView),
      MaterialRoute(page: LoginView),
      MaterialRoute(page: SignUpView),
    ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
// @stacked-service
  ],
)

class App{}