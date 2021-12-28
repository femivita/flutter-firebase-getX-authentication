import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;

  UserModel({this.id, this.firstName, this.lastName, this.email, this.phoneNumber,});

  UserModel.fromDocumentSnapshot({DocumentSnapshot? doc}) {
    id = doc!.id;
    firstName = doc["firstName"];
    lastName = doc["lastName"];
    email = doc["email"];
    phoneNumber = doc["phoneNumber"];
  }
}