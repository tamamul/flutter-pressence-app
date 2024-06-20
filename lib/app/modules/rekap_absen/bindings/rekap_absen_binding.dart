import 'package:get/get.dart';

import '../controllers/rekap_absen_controller.dart';

class RekapAbsenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekapAbsenController>(
      () => RekapAbsenController(),
    );
  }
}
