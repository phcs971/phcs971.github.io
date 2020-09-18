class Conquista {
  final String id;
  final String title;
  final String description;
  final String url;
  final DateTime date;
  final bool isOther;

  Conquista.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        url = map['url'],
        isOther = map['isOther'],
        date = DateTime.fromMillisecondsSinceEpoch(map['date']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'url': url,
        'isOther': isOther,
        'date': date.millisecondsSinceEpoch,
      };
}
