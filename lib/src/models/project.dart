import 'gallery_item.dart';

enum ProjectType { python, flutter, cpp, react, others }

class Project {
  final String id;

  GalleryImage top;
  String title;

  List<GalleryItem> gallery;

  List<String> description;

  ProjectType type;

  Project({this.id, this.top, this.title, this.gallery, this.description, this.type});

  Project.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        top = GalleryImage(map['top']),
        title = map['title'],
        gallery = map['gallery'].map((url) => GalleryImage(url)).toList(),
        type = ProjectType.values[map['type']];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'top': top.url,
      'title': title,
      'gallery': gallery.map((item) => item.toString()).toList(),
      'type': type.index,
    };
  }
}
