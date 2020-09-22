import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../utils/utils.dart';
import '../../models/models.dart';
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
    Link('https://github.com/phcs971', LinkType.github),
    Link(
      'https://www.linkedin.com/in/pedro-henrique-cordeiro-soares-835a2a179/',
      LinkType.linkedin,
    ),
    Link('https://www.facebook.com/pedroh.csoares', LinkType.facebook),
    Link('https://www.instagram.com/pedroh.cs/', LinkType.instagram),
    Link('https://twitter.com/phcs971', LinkType.twitter),
    Link('mailto:phcs.971@gmail.com', LinkType.email),
    Link('https://wa.me/5541999877804', LinkType.whatsapp),
    Link('tel:+5541999877804', LinkType.phone),
  ];

  @override
  Widget build(BuildContext context) {
    final key = scKey == null ? GlobalKey<ScaffoldState>() : scKey;

    final nav = locator<NavigationService>();
    final auth = locator<AuthService>();

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
              onPressed: isCurrent ? null : () => nav.popAllTo(item['route']),
            ),
          );
        }).toList();

        List<Widget> linksButtons = links.map<Widget>((link) {
          return IconButton(
            icon: Icon(kLinkToIcon[link.type], color: Theme.of(context).primaryColor),
            tooltip: kLinkToString[link.type],
            onPressed: () async {
              try {
                await launch(link.url);
              } catch (_) {
                cannotLaunchUrl(context);
              }
            },
          );
        }).toList();

        Widget logOutButton = IconButton(
          icon: Icon(Icons.logout, color: Theme.of(context).primaryColor),
          tooltip: "Sair",
          onPressed: () async {
            await auth.logOut();
            nav.popAllTo(StartupRoute);
          },
        );

        Widget divider = Container(height: 1, color: Colors.black45);

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
                                "Copyright © 2020 Pedro Henrique Cordeiro Soares. Todos os direitos reservados.\nVersão $version",
                                textAlign: TextAlign.center,
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
                    child: Column(children: [
                      SizedBox(height: 75),
                      ...linksButtons,
                      if (!kIsWeb) ...[
                        divider,
                        logOutButton,
                      ],
                    ]),
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
                padding: EdgeInsets.fromLTRB(25, 8, fullScreen ? 75 : 25, 8),
                // margin: fullScreen ? EdgeInsets.only(right: 74) : EdgeInsets.zero,
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
                        tooltip: 'Menu',
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
                        divider,
                        ...linksButtons,
                        if (!kIsWeb) ...[divider, logOutButton],
                      ],
                    ),
                  ),
                ),
          floatingActionButton: !kIsWeb && auth.currentUser.admin && [0, 1].contains(index)
              ? FloatingActionButton(
                  onPressed: () {
                    if (index == 0) return nav.push(NewProjectRoute);
                    if (index == 1) return nav.push(NewConquistaRoute);
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.add),
                )
              : null,
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
