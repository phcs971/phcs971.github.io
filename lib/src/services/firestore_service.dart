import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../locators.dart';
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
    log.v("<Firestore> Got Project $id -> ${doc.data()!['title']}");
    return Project.fromMap(doc.data()!);
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
        log.e("<Firestore> Creating user ${user.id} failed / ${(e as PlatformException).message}");
        return e.message;
      }
    }
  }

  Future getUser(String uid) async {
    try {
      log.v("<Firestore> Requesting user $uid");
      var userData = await firestore.collection("users").doc(uid).get();
      assert(userData.data() != null && userData.data()!.isNotEmpty, "USER_NOT_FOUND");
      log.v("<Firestore> Requesting user $uid success");
      return Profile.fromMap(userData.data()!);
    } catch (e) {
      log.e("<Firestore> Requesting user $uid failed / ${(e as PlatformException).message}");
      return e.message;
    }
  }

  Future<bool> userExists(String? uid) async {
    var userData = await firestore.collection("users").doc(uid).get();
    return userData.data() != null && userData.data()!.isNotEmpty;
  }

  Future createConquista(Conquista conquista, File file) async {
    try {
      log.v("<Firestore> Creating conquista ${conquista.title}");
      final ref = firestore.collection("achievements").doc();
      conquista.url = await locator<StorageService>().saveFotoConquista(file, ref.id);
      final data = conquista.toMap();
      data.update("id", (_) => ref.id);
      ref.set(data);
      log.i("<Firestore> Creating conquista ${conquista.title} success");
    } catch (e) {
      log.e("<Firestore> Creating conquista ${conquista.title} failed / ${e.toString()}");
    }
  }

  Future createProjeto(Project projeto, List<File> gallery) async {
    try {
      log.v("<Firestore> Creating projeto ${projeto.title}");
      final ref = firestore.collection("projects").doc();
      projeto.gallery = await locator<StorageService>().saveFotosProjetos(gallery, ref.id);
      final data = projeto.toMap();
      data.update("id", (_) => ref.id);
      ref.set(data);
      log.i("<Firestore> Creating projeto ${projeto.title} success");
    } catch (e) {
      log.e("<Firestore> Creating projeto ${projeto.title} failed / ${e.toString()}");
    }
  }
}
