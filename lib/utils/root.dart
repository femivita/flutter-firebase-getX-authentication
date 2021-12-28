import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_key/controllers/authController.dart';
import 'package:test_key/pages/home.dart';
import 'package:test_key/pages/login.dart';

class RootFolder extends GetWidget<AuthController> {
  static String? recipientCode;
  @override
  Widget build(BuildContext context) {
    return Obx(
        () => (controller.user != null) ? HomePage() : LoginScreen());
  }
}
