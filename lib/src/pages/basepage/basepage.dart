import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/utils.dart';
import '../base.dart';
import '../../locators.dart';

class BasePage extends StatelessWidget {
  final int index;
  final List<Widget> children;
  final GlobalKey<ScaffoldState> scKey;
  const BasePage({this.children, this.index, this.scKey});

  static final pages = [
    {'title': "Projetos", 'route': HomeRoute},
    {'title': "Conquistas", 'route': ConquistasRoute},
    {'title': "Mais Informações", 'route': InfoRoute},
  ];

  static final links = [
    {'icon': AntDesign.github, 'url': 'https://github.com/phcs971'},
    {
      'icon': AntDesign.linkedin_square,
      'url': 'https://www.linkedin.com/in/pedro-henrique-cordeiro-soares-835a2a179/',
    },
    {'icon': AntDesign.facebook_square, 'url': 'https://www.facebook.com/pedroh.csoares'},
    {'icon': AntDesign.instagram, 'url': 'https://www.instagram.com/pedroh.cs/'},
    {'icon': AntDesign.twitter, 'url': 'https://twitter.com/phcs971'},
    {'icon': MaterialCommunityIcons.gmail, 'url': 'mailto:phcs.971@gmail.com'},
    {'icon': FontAwesome.whatsapp, 'url': 'https://wa.me/5541999877804'},
    {'icon': FontAwesome.phone, 'url': 'tel:+5541999877804'},
  ];

  @override
  Widget build(BuildContext context) {
    final key = scKey == null ? GlobalKey<ScaffoldState>() : scKey;
    return ResponsiveBuilder(
      (context, info) {
        List<Widget> pagesButtons = pages.map<Widget>((item) {
          bool isCurrent = pages.indexOf(item) == index;
          return Container(
            width: 36 +
                textWidth(
                  item['title'],
                  Theme.of(context).textTheme.button.copyWith(fontWeight: FontWeight.bold),
                ),
            margin: const EdgeInsets.only(left: 8.0),
            child: FlatButton(
              child: Text(
                item['title'],
                style: Theme.of(context).textTheme.button.copyWith(
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              onPressed: isCurrent ? null : () => locator<NavigationService>().to(item['route']),
            ),
          );
        }).toList();

        List<Widget> linksButtons = links.map<Widget>((link) {
          return IconButton(
            icon: Icon(link['icon']),
            onPressed: () async {
              try {
                await launch(link['url']);
              } catch (_) {
                cannotLaunchUrl(context);
              }
            },
          );
        }).toList();

        bool fullScreen = info.localWidgetSize.width > 1050;
        return Scaffold(
          key: key,
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.topRight,
            children: [
              //Content
              Positioned(
                  top: 75,
                  left: 0,
                  right: fullScreen ? 75 : 0,
                  bottom: 0,
                  child: CustomScrollView(
                    slivers: [
                      ...children,
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                "Copyright © 2020 Pedro Henrique Cordeiro Soares. Todos os direitos reservados.",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              //Fullscren Shadow and Right
              if (fullScreen) ...[
                //Shadow
                IgnorePointer(
                  child: Container(
                    child: CustomPaint(painter: LShadowPainter(4)),
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                //Right
                Container(
                  width: 75,
                  height: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(children: [SizedBox(height: 75), ...linksButtons]),
                  ),
                ),
              ],
              //Not Fullscreen Shadow
              if (!fullScreen)
                IgnorePointer(
                  child: Container(
                    child: CustomPaint(painter: IShadowPainter(4)),
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              //Top
              Container(
                height: 75,
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(25, 8, fullScreen ? 0 : 25, 8),
                margin: fullScreen ? EdgeInsets.only(right: 75) : EdgeInsets.zero,
                child: Row(
                  children: [
                    //Logo
                    Container(width: 50, child: Image.asset('assets/images/icon.png')),
                    //Space
                    SizedBox(width: 25),
                    //Name
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          child: Text(
                            info.localWidgetSize.width > 700
                                ? "Pedro Henrique Cordeiro Soares"
                                : "Pedro Soares",
                            style: Theme.of(context).textTheme.headline4.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                    //FullScreen Pages
                    if (fullScreen) ...pagesButtons,
                    //Not FullScreen Drawer
                    if (!fullScreen) ...[
                      //Space
                      SizedBox(width: 25),
                      //Drawer
                      IconButton(
                        onPressed: () {
                          key.currentState.openEndDrawer();
                        },
                        icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
          endDrawer: fullScreen
              ? null
              : Container(
                  width: 200,
                  height: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...pagesButtons,
                        Container(height: 1, color: Colors.black45),
                        ...linksButtons
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class IShadowPainter extends CustomPainter {
  final int elevation;

  IShadowPainter(this.elevation);

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..lineTo(0, 75)
      ..lineTo(size.width, 75)
      ..lineTo(size.width, 0)
      ..close();
    var shadows = kElevationToShadow[elevation];
    for (var p in shadows.map((s) => s.toPaint())) canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class LShadowPainter extends CustomPainter {
  final int elevation;

  LShadowPainter(this.elevation);

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..lineTo(0, 75)
      ..lineTo(size.width - 75, 75)
      ..lineTo(size.width - 75, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    var shadows = kElevationToShadow[elevation];
    for (var p in shadows.map((s) => s.toPaint())) canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
