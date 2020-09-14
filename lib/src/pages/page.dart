import 'package:flutter/material.dart';
import 'package:portifolio/src/utils/utils.dart';

import 'base.dart';
import '../locators.dart';

class BasePage extends StatelessWidget {
  final int currentPage;
  final Widget child;
  const BasePage(this.child, this.currentPage);

  @override
  Widget build(BuildContext context) {
    final pages = [
      {'title': "Projetos", 'route': HomeRoute},
      {'title': "Mais Informações", 'route': InfoRoute},
    ];
    final mq = MediaQuery.of(context);
    final s = mq.size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          //Content
          Positioned(
            top: 125,
            left: 0,
            right: 75,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(child: child, constraints: BoxConstraints(minHeight: s.height - 125)),
                  Container(height: 75, color: Colors.blueGrey),
                ],
              ),
            ),
          ),
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
            padding: EdgeInsets.only(top: 125),
            color: Colors.white,
          ),
          //Top
          Container(
            height: 125,
            color: Colors.white,
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 37.5,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/images/qb1.jpg'),
                  ),
                ),
                SizedBox(width: 25),
                Text(
                  "Pedro Henrique Cordeiro Soares",
                  style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),
                ),
                Spacer(),
                ...pages.map<Widget>((item) {
                  bool isCurrent = pages.indexOf(item) == currentPage;
                  return Container(
                    width: textSize(
                            item['title'],
                            Theme.of(context).textTheme.button.copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                )).width +
                        36,
                    margin: const EdgeInsets.only(left: 8.0),
                    child: FlatButton(
                      child: Text(
                        item['title'],
                        style: Theme.of(context).textTheme.button.copyWith(
                              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                      onPressed:
                          isCurrent ? null : () => locator<NavigationService>().to(item['route']),
                    ),
                  );
                }),
                SizedBox(width: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LShadowPainter extends CustomPainter {
  final int elevation;

  LShadowPainter(this.elevation);

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..lineTo(0, 125)
      ..lineTo(size.width - 75, 125)
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
