import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/home/home.page.dart';

class PortifolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Portifólio',
      home: HomePage(),
    );
  }
}
