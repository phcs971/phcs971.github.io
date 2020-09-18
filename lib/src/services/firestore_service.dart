import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';
import '../utils/logger.dart';

class FirestoreService {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  Future<List<Project>> getProjects() async {
    log.v("<Firestore> Getting All Projects");
    final query = await firestore.collection('projects').get();
    List<Project> projects = [];
    for (var d in query.docs) projects.add(Project.fromMap(d.data()));
    log.v("<Firestore> Got ${projects.length} Projects");
    return projects;
  }

  Future<Project> getProject(String id) async {
    log.v("<Firestore> Getting Project $id");
    final doc = await firestore.collection('projects').doc(id).get();
    log.v("<Firestore> Got Project $id -> ${doc.data()['title']}");
    return Project.fromMap(doc.data());
  }

  Future<List<Conquista>> getConquistas() async {
    log.v("<Firestore> Getting All Achievements");
    final query = await firestore.collection('achievements').get();
    List<Conquista> conquistas = [];
    for (var d in query.docs) conquistas.add(Conquista.fromMap(d.data()));
    log.v("<Firestore> Got ${conquistas.length} Achievements");
    return conquistas;
  }
}
