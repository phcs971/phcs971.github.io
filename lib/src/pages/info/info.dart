import 'package:flutter/material.dart';

import '../basepage/basepage.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [SliverToBoxAdapter(child: Container(height: 200, width: double.infinity))],
      index: 2,
    );
  }
}
