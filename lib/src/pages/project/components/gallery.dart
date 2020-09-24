import 'package:flutter/material.dart';

import '../../../models/models.dart';

class GalleryWidget extends StatelessWidget {
  final List<GalleryItem> gallery;
  final Color backgroundColor;
  GalleryWidget(this.gallery, {Key key, this.backgroundColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: kElevationToShadow[4],
        color: Colors.white,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[4],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(child: gallery[index].build(context), color: backgroundColor),
          ),
        ),
        itemCount: gallery.length,
      ),
    );
  }
}
