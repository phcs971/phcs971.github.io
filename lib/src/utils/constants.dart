import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';

import 'package:portifolio/src/models/models.dart';

import 'icons/ExtraTech/extra_tech_icons_icons.dart';

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
  Status.tostart: MaterialCommunityIcons.progress_wrench,
  Status.wip: MaterialCommunityIcons.progress_clock,
  Status.paused: MaterialCommunityIcons.progress_alert,
  Status.closed: MaterialCommunityIcons.progress_check,
};

const kLinkToIcon = {
  LinkType.github: AntDesign.github,
  LinkType.link: Entypo.link,
  LinkType.linkedin: AntDesign.linkedin_square,
  LinkType.facebook: AntDesign.facebook_square,
  LinkType.instagram: AntDesign.instagram,
  LinkType.twitter: AntDesign.twitter,
  LinkType.email: Icons.mail,
  LinkType.whatsapp: FontAwesome.whatsapp,
  LinkType.phone: FontAwesome.phone,
  LinkType.web: MaterialCommunityIcons.web,
};

const kTechToString = {
  ProjectTech.python: "Python",
  ProjectTech.flutter: "Flutter",
  ProjectTech.cpp: "C++",
  ProjectTech.react: "React",
  ProjectTech.nodejs: "NodeJs",
  ProjectTech.witai: "Wit Ai",
  ProjectTech.sqlite: "SQLite",
  ProjectTech.kivy: "Kivy",
  ProjectTech.firebase: "Firebase",
  ProjectTech.woodworks: "Trabalho Manual",
  ProjectTech.others: "Outros",
};

const kStatusToString = {
  Status.tostart: "Ainda não Iniciado",
  Status.wip: "Em Progresso",
  Status.paused: "Pausado",
  Status.closed: "Concluído",
};

const kLinkToString = {
  LinkType.github: "GitHub",
  LinkType.link: "Arquivo",
  LinkType.linkedin: "Linkedin",
  LinkType.facebook: "Facebook",
  LinkType.instagram: "Instagram",
  LinkType.twitter: "Twitter",
  LinkType.email: "Email",
  LinkType.whatsapp: "WhatsApp",
  LinkType.phone: "Telefone",
  LinkType.web: "Página de Acesso"
};

const kCauseToString = {
  Cause.academics: "Acadêmico",
  Cause.competition: "para Competição",
  Cause.personal: "Pessoal",
  Cause.pro: "Profissional",
};
