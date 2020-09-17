import 'package:flutter/material.dart';

import '../basepage/basepage.dart';

class ProjectPage extends StatelessWidget {
  final String id;
  const ProjectPage(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [SliverToBoxAdapter(child: Container(height: 200, width: double.infinity))],
      index: -1,
    );
  }
}
