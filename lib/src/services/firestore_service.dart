import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore_web/cloud_firestore_web.dart';

// import 'package:flutter/foundation.dart';

import '../models/project.dart';

class FirestoreService {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  // FirebaseFirestoreWeb get firestoreWeb => FirebaseFirestoreWeb.;
  Future<List<Project>> getProjects() async {
    final query = await firestore.collection('projects').get();
    List<Project> projects = [];
    for (var d in query.docs) projects.add(Project.fromMap(d.data()));
    return projects;
  }
}
