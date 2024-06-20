import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD PEGAWAI'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.nipC,
            decoration:
                InputDecoration(labelText: "NIP", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            decoration: InputDecoration(
                labelText: "Name", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.jobC,
            decoration: InputDecoration(
                labelText: "Pangkat", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            decoration: InputDecoration(
                labelText: "Email", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          //DropDown Untuk Role
          DropdownButtonFormField<String>(
            value: controller.selectedRole.value,
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.selectedRole.value = newValue;
              }
            },
            items: <String>['pegawai', 'admin'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Role',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Button Untuk Submit
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.addPegawai();
                }
              },
              child: Text(
                  controller.isLoading.isFalse ? "ADD PEGAWAI" : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
