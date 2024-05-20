import 'package:appjamgrup51/app/app.locator.dart';
import 'package:appjamgrup51/app/app.router.dart';
import 'package:appjamgrup51/services/authentication_service.dart';
import 'package:appjamgrup51/ui/main/main_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends MainViewModel {
  final _authenticationservice = locator<AuthenticationService>();
  final _navigationservice = locator<NavigationService>();

  final db = FirebaseFirestore.instance;

  String? _userName;
  String? _userSurname;
  String? get userName => _userName;
  String? get userSurname => _userSurname;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> getUserInfo() async {
    setBusy(true);
    final docRef = db.collection('users').doc(currentUser!.uid);
    try {
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          _userName = data['name'];
          _userSurname = data['surname'];
          print(_userSurname);
          print(_userName);
          print(currentUser!.uid );
          rebuildUi();
        },
        onError: (e) => print("İsim yüklenirken hata oluştu $e"),
      );
    } catch (e) {
      print(e);
    } finally {
      setBusy(false);
      rebuildUi();
    }
  }

  void signOut() {
    _authenticationservice.signOut();
  }

  void goToLogin() {
    _navigationservice.replaceWithLoginView();
  }

}
