import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Belum Verifikasi",
              middleText:
                  "Kamu belum verifikasi akun ini. Lakukan verifikasi di email kamu",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    isLoading.value = false;
                    Get.offAllNamed(
                        Routes.LOGIN); // bisa buat tutup dialog juga
                  }, // bisa buat tutup dialog juga
                  child: Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.snackbar("Berhasil",
                          "Kami telah berhasil mengirim email verifikasi ke akun anda.");
                      isLoading.value = false;
                      Get.offAllNamed(Routes.LOGIN);
                    } catch (e) {
                      isLoading.value = false;
                      Get.snackbar("Terjadi Kesalahan",
                          "Tidak dapat mengirim email verifikasi.");
                    }
                  }, // bisa buat tutup dialog juga
                  child: Text("KIRIM ULANG"),
                ),
              ],
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("Error", "Email tidak terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Error", "Password salah");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Error", "Tidak dapat login");
      }
    } else {
      Get.snackbar("Error", "Email dan Password tidak boleh kosong");
    }
  }
}
