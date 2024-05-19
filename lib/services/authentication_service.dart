import 'dart:async';

import 'package:appjamgrup51/app/app.locator.dart';
import 'package:appjamgrup51/app/app.router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  static const int snackbarDuration = 2000;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<bool> userLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _snackbarService.showSnackbar(
        title: 'Giriş Başarılı',
        message: 'Hoşgeldin',
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
      _navigationService.replaceWithMainView();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Geçersiz e-posta adresi.';
          break;
        case 'user-disabled':
          errorMessage = 'Kullanıcı devre dışı bırakılmış.';
          break;
        case 'user-not-found':
          errorMessage = 'Kullanıcı bulunamadı.';
          break;
        case 'wrong-password':
          errorMessage = 'Yanlış şifre.';
          break;
        default:
          errorMessage = 'Giriş başarısız. Hata: ${e.message}';
      }
      _snackbarService.showSnackbar(
        title: 'Giriş Başarısız',
        message: errorMessage,
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
      return null;
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Giriş Başarısız',
        message: 'Bir hata oluştu: $e',
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String confirmPassword, String name, String surname) async {
    if (password != confirmPassword) {
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: 'Şifreler uyuşmuyor.',
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
      return null;
    }

    if (password.length < 6) {
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: 'Şifre en az 6 karakter olmalı.',
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
      return null;
    }

    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'surname': surname,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        _snackbarService.showSnackbar(
          title: 'Kayıt Başarılı',
          message: 'Merhaba $name',
        );
        Timer(const Duration(milliseconds: snackbarDuration), () {
          _snackbarService.closeSnackbar();
        });

        return user;
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Bu e-posta adresi zaten kullanılıyor.';
          break;
        case 'invalid-email':
          errorMessage = 'Geçersiz e-posta adresi.';
          break;
        case 'weak-password':
          errorMessage = 'Zayıf şifre, lütfen daha güçlü bir şifre kullanın.';
          break;
        default:
          errorMessage = 'Kayıt başarısız. Hata: ${e.message}';
      }

      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: errorMessage,
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });

      return null;
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: 'Bir hata oluştu: $e',
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });

      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
