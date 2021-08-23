import 'package:flutter/material.dart';

import '../utils.dart';

enum DeviceType { Mobile, Tablet, Desktop }

class ResponsiveBuilder extends StatefulWidget {
  ///Set this when you want the Tablet DeviceType to count as another Device like:
  ///
  ///Tablets as Mobile
  ///```dart
  ///tabletCountAs: DeviceType.Mobile
  ///```
  ///
  ///If null will return as [DeviceType.Tablet]
  final DeviceType? tabletCountAs;
  final Widget Function(BuildContext context, DeviceType type, bool isMobile) builder;
  ResponsiveBuilder({required this.builder, this.tabletCountAs, Key? key}) : super(key: key);

  @override
  _ResponsiveBuilderState createState() => _ResponsiveBuilderState();
}

class _ResponsiveBuilderState extends State<ResponsiveBuilder> with WidgetsBindingObserver {
  WidgetsBinding get widgetsBinding => WidgetsBinding.instance!;

  late DeviceType deviceType;

  @override
  void initState() {
    super.initState();
    widgetsBinding.addObserver(this);
    setDeviceType();
  }

  @override
  void dispose() {
    widgetsBinding.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(setDeviceType);
  }

  void setDeviceType() {
    final width = Get.width;
    if (width > 780) {
      deviceType = DeviceType.Desktop;
    } else if (width > 480) {
      deviceType = widget.tabletCountAs ?? DeviceType.Tablet;
    } else {
      deviceType = DeviceType.Mobile;
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, deviceType, deviceType == DeviceType.Mobile);
}
