import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectionModules {
  @singleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get cloudFireStore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseApp get firebaseApp => Firebase.app();
}
