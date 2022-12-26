import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_user_controller.dart';

class RegisterUserView extends GetView<RegisterUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterUserView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.nameC,
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.emailC,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.registerUser();
                }
              },
              child: Text(
                controller.isLoading.isFalse ? "Register User" : "Please Wait",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
