import 'package:appjamgrup51/ui/signup/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  SignUpView({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController surnamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();

  @override
  Widget builder(BuildContext context, SignUpViewModel viewModel, Widget? child) {
    // Ekran boyutlarını al
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, Colors.blue.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                //TODO Uygulama Logosunu buraya ekle
                const Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 50),

                //İSİM
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'İsim',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //SOYİSİM
                TextField(
                  controller: surnamecontroller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Soyisim',
                    prefixIcon: Icon(Icons.subtitles_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // EMAİL
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ŞİFRE
                TextField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Şifre',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //ŞİFRE TEKRARI
                TextField(
                  controller: confirmpasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Şifrenizi tekrar giriniz',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Giriş Butonu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.signUp(emailcontroller.text, passwordcontroller.text,confirmpasswordController.text,namecontroller.text,surnamecontroller.text,);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0), backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), // Buton rengi
                    ),
                    child: const Text(
                      'Kayıt ol',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Kayıt Olma ve Şifremi Unuttum Linkleri
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Zaten bir hesaba sahip misiniz?",style: TextStyle(color: Colors.white),),
                    TextButton(
                      onPressed: () {
                        viewModel.goToLogin();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,

                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  @override
  SignUpViewModel viewModelBuilder(BuildContext context) {
    return SignUpViewModel();
  }
}