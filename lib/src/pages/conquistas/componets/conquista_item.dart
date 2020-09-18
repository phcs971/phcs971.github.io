import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../models/conquista.dart';

class ConquistaItem extends StatelessWidget {
  final Conquista conquista;
  const ConquistaItem(this.conquista, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: conquista.title,
      child: InkWell(
        onTap: () => dialogConquista(context, conquista),
        // onTap: () => locator<NavigationService>().push("$HomeRoute/${project.id}"),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: kElevationToShadow[2],
          ),
          child: ClipRRect(
            child: Image.network(conquista.url),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
