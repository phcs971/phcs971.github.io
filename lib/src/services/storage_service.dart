import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../models/models.dart';
import '../utils/utils.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  Future<String> saveFotoConquista(File file, String id) async {
    log.v("<Storage> Saving foto Conquista $id");
    final ref = storage.ref().child("achievements/$id/${file.path.split("/").last}");
    final task = ref.putFile(file);
    await task;
    log.i("<Storage> Saving foto Conquista $id Success");
    return await ref.getDownloadURL();
  }

  Future<List<GalleryItem>> saveFotosProjetos(List<File> files, String id) async {
    log.v("<Storage> Saving ${files.length} fotos Projeto $id");
    final strref = storage.ref().child("projects/$id");
    List<GalleryItem> urls = [];
    int i = 1;
    for (var file in files) {
      log.v("<Storage> Saving photos $i from Projeto $id");
      i++;
      final ref = strref.child(file.path.split("/").last);
      final task = ref.putFile(file);
      await task;
      urls.add(GalleryItem.url(await ref.getDownloadURL()));
    }
    log.i("<Storage> Saving fotos Projeto $id Success");
    return urls;
  }
}
