enum LinkType { github, link }

class Link {
  final String url;
  final LinkType type;

  Link.fromMap(Map<String, dynamic> map)
      : url = map['url'],
        type = LinkType.values[map['type']];

  Map<String, dynamic> toMap() => {'url': url, 'type': type.index};
}
