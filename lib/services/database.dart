import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:test_key/controllers/authController.dart';
import 'package:test_key/model/user.dart';

class DataBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String uid = Get
      .find<AuthController>()
      .user!
      .uid;
  String email = Get
      .find<AuthController>()
      .user!
      .email!;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.email).set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUser(String email) async {
    try {
      DocumentSnapshot _doc =
      await _firestore.collection('users').doc(email).get();

      return UserModel.fromDocumentSnapshot(doc: _doc);
    } catch (e) {
      rethrow;
    }
  }
}