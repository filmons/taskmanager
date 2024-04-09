import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/model/task.dart';
import 'package:uuid/uuid.dart';

class FirestoreController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> addTask(String titre, String description, String image) async {
    try {
      var uuid = Uuid().v4();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('tasks')
          .doc(uuid)
          .set({
        'id': uuid,
        'titre': titre,
        'description': description,
        'image': image,
        'isDone': false,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  List getTasks(AsyncSnapshot snapshot) {
    try {
      final tasksList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Task(
          data['id'],
          data['titre'],
          data['description'],
          data['image'],
          data['isDone'],
        );
      }).toList();
      return tasksList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('tasks')
        .where('isDone', isEqualTo: isDone)
        .snapshots();
  }

  Future<bool> isDone(String uuid, bool isDone) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('tasks')
          .doc(uuid)
          .update({'isDone': isDone});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> updateTask(
      String uuid, String titre, String description, String image) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('tasks')
          .doc(uuid)
          .update({
        'titre': titre,
        'description': description,
        'image': image,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> deleteNote(String uuid) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('tasks')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }
}
