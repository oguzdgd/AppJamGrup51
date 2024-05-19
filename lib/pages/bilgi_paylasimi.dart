import 'package:appjamgrup51/app/app.locator.dart';
import 'package:appjamgrup51/app/app.router.dart';
import 'package:appjamgrup51/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class BilgiPaylasimi extends StatefulWidget {
  const BilgiPaylasimi({super.key});

  @override
  State<BilgiPaylasimi> createState() => _BilgiPaylasimiState();
}

class _BilgiPaylasimiState extends State<BilgiPaylasimi> {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _authenticationService.signOut();
            _navigationService.replaceWith(Routes.loginView);
          },
          child: Text("Çıkış Yap"),
        ),
      ),
    );
  }
}
