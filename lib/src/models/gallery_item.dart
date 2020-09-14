import 'package:flutter/material.dart';

abstract class GalleryItem {
  Widget build(BuildContext context);
  String toString();
}

class GalleryImage extends GalleryItem {
  final String url;

  GalleryImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Image.network(url);
  }

  @override
  String toString() {
    return url;
  }
}
