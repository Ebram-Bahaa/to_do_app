import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TodoRepository {
  final _firestore = FirebaseFirestore.instance;
  final _firebaseauth = FirebaseAuth.instance;
  Future<void> addTodo({
    required String title,
    required String description,
  }) async {
    final user = _firebaseauth.currentUser;
    if (user == null) {
      throw Exception("You Must Be signed To Add To Do");
    }
    await _firestore.collection('todos').add({
      "title": title,
      "description": description,
      "userId": user.uid,
      "CreatedAt": FieldValue.serverTimestamp(),
    });
  } 
}
