import 'package:flutter/material.dart';

enum GalleryType { image, video }

class GalleryItem {
  final String url;
  final GalleryType type;

  GalleryItem.url(this.url) : type = GalleryType.image;

  GalleryItem.fromMap(Map<String, dynamic> map)
      : url = map['url'],
        type = GalleryType.values[map['type']];

  Map<String, dynamic> toMap() => {'url': url, 'type': type.index};

  Widget build(BuildContext context) => Image.network(url);
}
