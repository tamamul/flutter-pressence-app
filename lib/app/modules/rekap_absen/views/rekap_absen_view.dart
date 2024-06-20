import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/rekap_absen_controller.dart';

class RekapAbsenView extends GetView<RekapAbsenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekap Presensi'),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.absenItems.length,
            itemBuilder: (context, index) {
              var item = controller.absenItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(
                  item.hasAttended ? 'Sudah Presensi' : 'Belum Presensi',
                  style: item.hasAttended
                      ? TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      : null,
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        // Pindahkan ke sini
        onPressed: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
          );

          if (pickedDate != null) {
            controller.checkAttendance(pickedDate);
          }
        },
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}
