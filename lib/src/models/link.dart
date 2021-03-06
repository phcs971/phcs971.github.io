enum LinkType { github, link, linkedin, facebook, instagram, twitter, email, whatsapp, phone, web }

class Link {
  final LinkType type;
  String? url;

  Link(this.url, this.type);

  Link.create(this.type);

  Link.fromMap(Map<String, dynamic> map)
      : url = map['url'],
        type = LinkType.values[map['type']];

  Map<String, dynamic> toMap() => {'url': url, 'type': type.index};
}
