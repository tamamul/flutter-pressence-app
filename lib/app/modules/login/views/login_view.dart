import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:presence/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  // Lazy initialization of ForgotPasswordController
  LoginView() {
    Get.lazyPut(() => ForgotPasswordController());
  }
  Future<String?> _authUser(LoginData data) async {
    controller.emailC.text = data.name;
    controller.passC.text = data.password;
    await controller.login();

    // Assuming that if a user is logged in after calling the login method, it was successful.
    if (controller.auth.currentUser != null) {
      return null; // Indicate successful login with no error
    } else {
      return "Login failed"; // Generic error message
    }
  }

  Future<String?> _registerUser(LoginData data) {
    // Placeholder for the registration logic
    return Future.value(null);
  }

  Future<String?> _recoverPassword(String name) async {
    final forgotPasswordController = Get.find<ForgotPasswordController>();
    forgotPasswordController.emailC.text = name;
    return await forgotPasswordController.sendEmail();
  }

  Future<String?> _registerUserWrapper(SignupData data) {
    // Convert SignupData to LoginData
    LoginData loginData = LoginData(name: data.name!, password: data.password!);
    return _registerUser(loginData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: FlutterLogin(
        title: 'Presence',
        onLogin: _authUser,
        onSignup: null,
        onSubmitAnimationCompleted: () {},
        onRecoverPassword: _recoverPassword,
        messages: LoginMessages(
          userHint: 'Email',
          passwordHint: 'Password',
          confirmPasswordHint: 'Confirm',
          loginButton: 'MASUK',
          signupButton: 'DAFTAR',
          forgotPasswordButton: 'LUPA PASSWORD?',
          recoverPasswordButton: 'BANTUAN',
          goBackButton: 'KEMBALI',
          confirmPasswordError: 'Password tidak cocok!',
          recoverPasswordDescription:
              'Kami akan mengirimkan instruksi ke email Anda',
          recoverPasswordSuccess: 'Password telah dikirim ke email Anda',
        ),
      ),
    );
  }
}
