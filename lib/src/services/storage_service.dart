import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../utils/utils.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  Future<String> saveFotoConquista(File file, String id) async {
    log.v("<Storage> Saving foto Conquista $id");
    final ref = storage.ref().child("achievements/$id/${file.path.split("/").last}");
    final task = ref.putFile(file);
    await task.onComplete;
    log.i("<Storage> Saving foto Conquista $id Success");
    return await ref.getDownloadURL();
  }

  Future<List<String>> saveFotosProjetos(List<File> files, String id) async {
    log.i("<Storage> Saving fotos Projeto $id");
    final strref = storage.ref().child("projects/$id");
    List<String> urls = [];
    for (var file in files) {
      final ref = strref.child(file.path.split("/").last);
      final task = ref.putFile(file);
      await task.onComplete;
      urls.add(await ref.getDownloadURL());
    }
    log.i("<Storage> Saving fotos Projeto $id Success");
    return urls;
  }
}
