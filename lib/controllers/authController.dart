import 'package:flutter/material.dart';
import 'package:test_key/controllers/userController.dart';
import 'package:test_key/model/user.dart';
import 'package:test_key/pages/login.dart';
import 'package:test_key/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:test_key/utils/root.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    // TODO: implement onInit
    _firebaseUser.bindStream(_auth.userChanges());
    super.onInit();
  }

  void createUser(String firstName, String lastName, String email,
      String password, String phoneNumber) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);

      UserModel _user = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: userCredential.user!.email,
        phoneNumber: phoneNumber,
      );

      if (await DataBase().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.dialog(
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color.fromRGBO(255, 255, 255, 1)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Icon(
                        Icons.check_circle,
                        size: 150,
                        color: Color.fromRGBO(10, 160, 110, 1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Success',
                      style: TextStyle(
                          color: Color.fromRGBO(86, 190, 212, 1),
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You have been registered',
                      style: TextStyle(
                          color: Color.fromRGBO(107, 118, 129, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color.fromRGBO(87, 68, 172, 1)),
                        child: TextButton(
                            onPressed: () {
                              Get.offAll(() => RootFolder());
                            },
                            child: Text(
                              "Continue",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().user =
          await DataBase().getUser(userCredential.user!.email!);
      Get.offAll(() => RootFolder());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar('Success',
          'check your email and follow the intruction to reset your password',
          duration: Duration(seconds: 10));
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
      Get.offAll(() => RootFolder());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
