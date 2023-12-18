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

  T fold<T>(T mobile, T desktop) {
    switch (this) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.desktop:
        return desktop;
    }
  }
}

class Device extends InheritedWidget {
  final DeviceType deviceType;

  const Device({
    required this.deviceType,
    required super.child,
    super.key,
  });

  static DeviceType of(BuildContext context) {
    final device =
        context.dependOnInheritedWidgetOfExactType<Device>()?.deviceType;
    return device ?? DeviceType.mobile;
  }

  @override
  bool updateShouldNotify(Device oldWidget) {
    return deviceType != oldWidget.deviceType;
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
        return Device(
          deviceType: deviceType,
          child: Builder(builder: (context) => builder(context, deviceType)),
        );
      },
    );
  }
}
