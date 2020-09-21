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

  Future createUser(Profile user) async {
    if (!(await userExists(user.id))) {
      try {
        log.v("<Firestore> Creating user ${user.id}");
        await firestore.collection("users").doc(user.id).set(user.toMap());
        log.i("<Firestore> Creating user ${user.id} success");
      } catch (e) {
        log.e("<Firestore> Creating user ${user.id} failed / ${e.message}");
        return e.message;
      }
    }
  }

  Future getUser(String uid) async {
    try {
      log.v("<Firestore> Requesting user $uid");
      var userData = await firestore.collection("users").doc(uid).get();
      assert(userData != null && userData.data() != null && userData.data().isNotEmpty,
          "USER_NOT_FOUND");
      log.v("<Firestore> Requesting user $uid success");
      return Profile.fromMap(userData.data());
    } catch (e) {
      log.e("<Firestore> Requesting user $uid failed / ${e.message}");
      return e.message;
    }
  }

  Future<bool> userExists(String uid) async {
    var userData = await firestore.collection("users").doc(uid).get();
    return userData != null && userData.data() != null && userData.data().isNotEmpty;
  }
}
