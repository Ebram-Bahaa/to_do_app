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
    final _doc = await _firestore.collection('todos').doc();
    _doc.set({
      "userId": _doc.id,
      "title": title,
      "description": description,
      "CreatedAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> editToDo({required title, required description}) async {
    final _doc = await _firestore.collection('todos').doc('userId');
    _doc.update({
      "title": title,
      "description": description,
      "CreatedAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteToDo() async {
    final _doc = await _firestore.collection('todos').doc('userId');
    _doc.delete();
  }
}
