import 'package:test_key/controllers/authController.dart';
import 'package:get/get.dart';
import 'package:test_key/controllers/userController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
  }
}