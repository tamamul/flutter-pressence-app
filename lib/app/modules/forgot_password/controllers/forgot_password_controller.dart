import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        isLoading.value = false;
        return null; // Indicate success by returning null
      } catch (e) {
        isLoading.value = false;
        return "Failed to send recovery email. Please try again."; // Return error message
      }
    } else {
      return "Please enter a valid email address."; // Return error message for empty email
    }
  }
}
