import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AbsenItem {
  final String name;
  final bool hasAttended;

  AbsenItem({required this.name, this.hasAttended = false});
}

class RekapAbsenController extends GetxController {
  final RxList<AbsenItem> absenItems = <AbsenItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Memuat data awal tanpa filter tanggal
  }

  void checkAttendance(DateTime date) {
    fetchAbsenDataForDate(date);
    update();
  }

  Future<void> fetchAbsenDataForDate(DateTime date) async {
    try {
      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('pegawai');
      List<AbsenItem> items = [];
      String dateStr = DateFormat('MM-dd-yyyy')
          .format(date); // Format tanggal sesuai Firestore

      QuerySnapshot usersSnapshot = await usersRef.get();
      for (var userDoc in usersSnapshot.docs) {
        DocumentSnapshot presenceDoc = await usersRef
            .doc(userDoc.id)
            .collection('presence')
            .doc(dateStr)
            .get();

        // Tambahkan pemeriksaan null di sini
        Map<String, dynamic>? data =
            presenceDoc.data() as Map<String, dynamic>?;
        bool hasAttended = data != null && data.containsKey('masuk');

        items.add(AbsenItem(name: userDoc['name'], hasAttended: hasAttended));
      }

      absenItems.assignAll(items);
    } catch (e) {
      print('Error fetching attendance data for date: $e');
    }
  }
}
