import 'package:flutter/material.dart';

enum DeviceType { Desktop, Tablet, Mobile }

class SizingInformation {
  final Orientation? orientation;
  final DeviceType? deviceType;
  final Size? screenSize, localWidgetSize;

  SizingInformation({
    this.orientation,
    this.deviceType,
    this.screenSize,
    this.localWidgetSize,
  });
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext, SizingInformation) builder;
  const ResponsiveBuilder(this.builder);

  DeviceType getDeviceType(MediaQueryData mq) {
    final deviceWidth = mq.size.shortestSide;
    if (deviceWidth > 950) return DeviceType.Desktop;
    if (deviceWidth > 600) return DeviceType.Tablet;
    return DeviceType.Mobile;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final mq = MediaQuery.of(context);
        var sizingInformation = SizingInformation(
          orientation: mq.orientation,
          screenSize: mq.size,
          localWidgetSize: Size(c.maxWidth, c.maxHeight),
          deviceType: getDeviceType(mq),
        );
        return builder(context, sizingInformation);
      },
    );
  }
}

class ScreenTypeLayout extends StatelessWidget {
  final Function(BuildContext, SizingInformation)? mobile, tablet, desktop;

  const ScreenTypeLayout({required this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder((c, i) {
      if (i.deviceType == DeviceType.Tablet) return tablet != null ? tablet!(c, i) : mobile!(c, i);
      if (i.deviceType == DeviceType.Desktop)
        return desktop != null ? desktop!(c, i) : tablet != null ? tablet!(c, i) : mobile!(c, i);
      return mobile!(c, i);
    });
  }
}

class OrientationLayout extends StatelessWidget {
  final Widget? landscape, portrait;

  OrientationLayout({required this.portrait, this.landscape});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) return landscape ?? portrait!;
    return portrait!;
  }
}
