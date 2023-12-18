import 'dart:async';

import 'package:flutter/material.dart';

class BannersCarouselWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final List<String> images;
  const BannersCarouselWidget(this.images,
      {super.key, this.height, this.width});

  @override
  State<BannersCarouselWidget> createState() => _BannersCarouselWidgetState();
}

class _BannersCarouselWidgetState extends State<BannersCarouselWidget> {
  late Timer timer;

  int index = 0;

  void onTimer(Timer timer) => setState(() => index++);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 7), onTimer);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget _buildImage(BuildContext context, int index) {
    final realIndex = index % widget.images.length;
    return Image.asset(
      widget.images[realIndex],
      height: widget.height,
      width: widget.width,
      fit: BoxFit.cover,
      key: ValueKey(realIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      child: _buildImage(context, index),
    );
  }
}
