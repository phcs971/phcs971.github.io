import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'gallery_item.dart';
import 'link.dart';

enum ProjectTech {
  python, //0
  flutter, //1
  cpp, //2
  react, //3
  nodejs, //4
  witai, //5
  sqlite, //6
  kivy, //7
  firebase, //8
  woodworks, //9
  others //10
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
        links = (map['links'] as List)?.map<Link>((l) => Link.fromMap(l))?.toList(),
        gallery =
            (map['gallery'] as List)?.map<GalleryItem>((g) => GalleryItem.fromMap(g))?.toList(),
        cause = Cause.values[map['cause']],
        techs = (map['techs'] as List).map<ProjectTech>((i) => ProjectTech.values[i]).toList(),
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
