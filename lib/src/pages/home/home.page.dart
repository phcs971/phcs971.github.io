import 'package:flutter/material.dart';
import 'package:portifolio/src/utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      tabletCountAs: DeviceType.Mobile,
      builder: (context, deviceType, isMobile) {
        List<Widget> _buildTopCurves() {
          final hU = Get.width / 1440;
          return [
            Positioned(
              bottom: 100 * hU,
              left: 0,
              child: ClipPath(
                clipper: TopClipper(1),
                child: Container(
                  height: 150 * hU,
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [PortifolioColors.blue[700]!, PortifolioColors.blue],
                      center: Alignment.bottomLeft,
                      radius: 3,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 80 * hU,
              left: Get.width / 18,
              child: ClipPath(
                clipper: TopClipper(2),
                child: Container(
                  height: 170 * hU,
                  width: Get.width * 8 / 9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [PortifolioColors.blue[700]!, PortifolioColors.blue[800]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ];
        }

        Widget _buildTopContent() => ClipPath(
              clipper: TopClipper(3),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [PortifolioColors.blue[800]!, PortifolioColors.blue],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 750),
                    SizedBox(height: 250),
                  ],
                ),
              ),
            );

        Widget _buildTop() => SliverToBoxAdapter(
              child: Container(
                width: Get.width,
                color: PortifolioColors.blue[600]!,
                child: Stack(children: [..._buildTopCurves(), _buildTopContent()]),
              ),
            );

        Widget _buildFooter() => SliverToBoxAdapter(
              child: Container(
                width: Get.width,
                height: isMobile ? 56 : 160,
                decoration: BoxDecoration(color: PortifolioColors.blue),
                padding: EdgeInsets.all(4).copyWith(bottom: 8),
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: PortifolioColors.yellow,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "© 2021 Pedro Henrique Cordeiro Soares.\nTodos os direitos reservados.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: PortifolioColors.white),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );

        return Scaffold(
          backgroundColor: PortifolioColors.blue,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              _buildTop(),
              SliverToBoxAdapter(
                child: Container(
                  width: Get.width,
                  height: 1000,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [PortifolioColors.blue[600]!, PortifolioColors.blue[700]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: Get.width,
                  height: 2000,
                  decoration: BoxDecoration(
                    color: PortifolioColors.blue[700]!,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: Get.width,
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [PortifolioColors.blue[700]!, PortifolioColors.blue],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              _buildFooter(),
            ],
          ),
        );
      },
    );
  }
}

class TopClipper extends CustomClipper<Path> {
  final int level;
  TopClipper(this.level);

  @override
  Path getClip(Size size) {
    final path = Path();
    if (level == 1) {
      final quarter = size.width / 4;
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..cubicTo(quarter * 3, size.height, quarter, size.height, 0, size.height)
        ..close();
    } else if (level == 2) {
      final third = Get.width / 3;
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..cubicTo(third * 2, size.height, third, size.height, 0, 0)
        ..close();
    } else if (level == 3) {
      final third = size.width / 3;
      final hOff = Get.width * 250 / 1440;
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..cubicTo(third * 2, size.height - hOff, third, size.height - hOff, 0, size.height - hOff)
        ..close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
