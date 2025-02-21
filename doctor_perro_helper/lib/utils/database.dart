import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

CollectionReference getCollection(String path) => db.collection(path);
