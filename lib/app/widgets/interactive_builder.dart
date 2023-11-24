import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  desktop;

  static DeviceType getDeviceType(double width) {
    if (width > 950) {
      return DeviceType.desktop;
    } else {
      return DeviceType.mobile;
    }
  }
}

class InteractiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const InteractiveBuilder(this.builder, {super.key});

  factory InteractiveBuilder.handle(
      {required WidgetBuilder mobile,
      required WidgetBuilder desktop,
      Key? key}) {
    return InteractiveBuilder((context, deviceType) {
      switch (deviceType) {
        case DeviceType.mobile:
          return mobile(context);
        case DeviceType.desktop:
          return desktop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = DeviceType.getDeviceType(constraints.maxWidth);
        return builder(context, deviceType);
      },
    );
  }
}
