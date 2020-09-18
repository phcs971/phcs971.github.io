import 'package:flutter/material.dart';

import '../../../models/models.dart';

class GalleryWidget extends StatelessWidget {
  final List<GalleryItem> gallery;
  GalleryWidget(this.gallery, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
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
            child: gallery[index].build(context),
          ),
        ),
        itemCount: gallery.length,
      ),
    );
  }
}
