import 'dart:ui';

import 'gallery_item.dart';
import 'link.dart';

enum ProjectTech {
  python, //0
  flutter, //1
  cpp, //2
  reactjs, //3
  reactnative, //4
  nodejs, //5
  witai, //6
  sqlite, //7
  kivy, //8
  firebase, //9
  woodworks, //10
  others //11
}
enum Status { tostart, wip, paused, closed }
enum Cause { pro, competition, personal, academics }

class Project {
  final String id;

  final String title;
  final String description;

  final DateTime start;
  final DateTime end;

  final Status status;

  final List<Link> links;
  final List<GalleryItem> gallery;

  final Cause cause;

  final List<ProjectTech> techs;

  final Color mainColor;
  final Color backgroundColor;

  Project.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        start = map['start'] != null ? DateTime.fromMillisecondsSinceEpoch(map['start']) : null,
        end = map['end'] != null ? DateTime.fromMillisecondsSinceEpoch(map['end']) : null,
        status = Status.values[map['status']],
        links = map['links']?.map((l) => Link.fromMap(l))?.toList(),
        gallery = map['gallery']?.map((g) => GalleryItem.fromMap(g))?.toList(),
        cause = Cause.values[map['cause']],
        techs = map['techs'].map((i) => ProjectTech.values[i]).toList(),
        mainColor = Color(map['mainColor']),
        backgroundColor = Color(map['backgroundColor']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'start': start?.millisecondsSinceEpoch,
        'end': end?.millisecondsSinceEpoch,
        'status': status.index,
        'links': links?.map((l) => l.toMap())?.toList(),
        'gallery': gallery?.map((g) => g.toMap())?.toList(),
        'cause': cause.index,
        'techs': techs.map((i) => i.index).toList(),
        'mainColor': mainColor.value,
        'backgroundColor': backgroundColor.value,
      };
}
