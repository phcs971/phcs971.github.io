import 'package:flutter/material.dart';

import '../basepage/basepage.dart';

class ConquistasPage extends StatelessWidget {
  const ConquistasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [SliverToBoxAdapter(child: Container(height: 200, width: double.infinity))],
      index: 1,
    );
  }
}
