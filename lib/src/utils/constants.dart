import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';

import 'package:portifolio/src/models/models.dart';

import 'fonts/ExtraTech/extra_tech_icons_icons.dart';

const primaryColor = Color(0xFF11144D); //    #11144D
const backgroundColor = Color(0xFFFFFFFF); // #FFFFFF

const String longAppName = 'Portifólio Pessoal';
const String shortAppName = 'PP';

const kTechToIcon = {
  ProjectTech.python: FontAwesome5Brands.python,
  ProjectTech.flutter: ExtraTechIcons.flutter,
  ProjectTech.cpp: MaterialCommunityIcons.language_cpp,
  ProjectTech.react: FontAwesome5Brands.react,
  ProjectTech.nodejs: FontAwesome5Brands.node_js,
  ProjectTech.witai: ExtraTechIcons.witai,
  ProjectTech.sqlite: ExtraTechIcons.sqlite,
  ProjectTech.kivy: ExtraTechIcons.kivy,
  ProjectTech.firebase: MaterialCommunityIcons.firebase,
  ProjectTech.woodworks: MaterialCommunityIcons.toolbox,
  ProjectTech.others: Icons.category,
};

const kStatusToIcon = {
  Status.tostart: AntDesign.clockcircleo,
  Status.wip: AntDesign.doubleright,
  Status.paused: AntDesign.pause,
  Status.closed: AntDesign.check,
};
