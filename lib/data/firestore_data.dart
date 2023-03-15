// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<dynamic> signUpUser(
    {required BuildContext context,
    required String userName,
    required String userEmail,
    required String userPassword}) async {
  try {
    final newuser = await firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail, password: userPassword);

    await addUser(name: userName, email: userEmail, password: userPassword);
    Navigator.pushReplacementNamed(context, 'Home_Screen');
    return newuser;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> signInUser(
    {required BuildContext context,
    required String email,
    required String password}) async {
  try {
    final newuser = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    Navigator.pushReplacementNamed(context, 'Home_Screen');
    return newuser;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> addUser({
  required String name,
  required String email,
  required String password,
  //dynamic profileImage,
}) async {
  try {
    final firebase = FirebaseFirestore.instance.collection('user');
    return firebase.add({
      'name': name,
      'email': email,
      'password': password,
      //'profileImage': profileImage,
    });
  } catch (e) {
    print(e);
  }
}

Future<dynamic> getUser() async {
  dynamic userId, userData;
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('user').get();
    userData = querySnapshot.docs.map((doc) {
      userId = doc.id;
      doc.data();
      return {'id': userId, ...doc.data()};
    }).toList();
    return userData;
  } catch (e) {
    print(e);
  }
}

dynamic addProfileImage({
  required dynamic docId,
  required String name,
  required String email,
  required String password,
  required String profileImage,
}) {
  try {
    final firebase = FirebaseFirestore.instance;
    return firebase.collection('user').doc(docId).set({
      'name': name,
      'email': email,
      'password': password,
      'profileImage': profileImage,
    });
  } catch (e) {
    print(e);
  }
}

Future<dynamic> addMessage({
  required dynamic docId,
  required List<dynamic> message,
}) async {
  try {
    final firebase = FirebaseFirestore.instance;
    return firebase.collection('message').doc(docId).set({
      'message': message,
    });
  } catch (e) {
    print(e);
  }
}

dynamic getMessage({required String docId}) async {
  final db = FirebaseFirestore.instance;
  final docRef = db.collection("message").doc(docId);
  return await docRef.get();
}

Future<dynamic> getAllMessage() async {
  dynamic messageId, messageData;
  try {
    final firebase = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firebase.collection('message').get();
    messageData = querySnapshot.docs.map((doc) {
      messageId = doc.id;
      doc.data();
      return {'id': messageId, ...doc.data()};
    }).toList();
    // print(messageData);
    return messageData;
  } catch (e) {
    print(e);
  }
}

String getCurrentUser() {
  final userEmail = firebaseAuth.currentUser.email;
  return userEmail;
}

Future<dynamic> getCurrentUserAllDetail({required String docId}) async {
  final db = FirebaseFirestore.instance.collection('user');
  final docRef = db.doc(docId).get().then((value) => value.data());
  return await docRef;
}
