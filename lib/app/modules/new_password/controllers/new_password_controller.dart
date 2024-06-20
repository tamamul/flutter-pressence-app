import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newpassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  
  void newPassword() async {
    if (newpassC.text.isNotEmpty) {
      if (newpassC.text != "password") {
      try {
        String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newpassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: newpassC.text);

          Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
            Get.snackbar("Error", "Sandi minimal 6 karakter");
          } 
          } catch (e) {
            Get.snackbar("Terjadi Kesalahan", "Tidak dapat membuat password baru");
          }
      
      } else {
      Get.snackbar("Terjadi Kesalahan", "Harap ubah kata sandi Anda, jangan menggunakan 'password' sebagai pilihan kata sandi Anda lagi");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password baru wajib diisi");
    }
  }
}
