import 'dart:ui';

import 'package:dragonflylabs/app/design/colors.dart';
import 'package:dragonflylabs/app/widgets/interactive_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

enum AppBarState {
  home("Dragonfly Labs"),
  work("Our work"),
  contact("Contact us");

  final String title;

  const AppBarState(this.title);
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarState state;
  final DeviceType deviceType;
  final bool scrolled;

  const CustomAppBar(
    this.state, {
    super.key,
    required this.deviceType,
    this.scrolled = false,
  });

  Widget _buildButton({
    required BuildContext context,
    required String title,
    VoidCallback? onPressed,
    bool selected = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: selected ? AppColors.yellow : Colors.transparent,
            width: 3,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          foregroundColor: AppColors.white,
          textStyle: const TextStyle(fontSize: 24),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = switch (deviceType) {
      DeviceType.mobile => AppBar(
          title: Text(
            state.title,
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: state != AppBarState.home
              ? IconButton(
                  tooltip: "Back",
                  onPressed: () {
                    if (Modular.to.canPop()) {
                      Modular.to.pop();
                    } else {
                      Modular.to.pushReplacementNamed("/");
                    }
                  },
                  color: AppColors.white,
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                )
              : null,
          foregroundColor: AppColors.white,
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton<AppBarState>(
              icon: const Icon(
                Icons.menu,
                color: AppColors.white,
              ),
              onSelected: (value) =>
                  Modular.to.pushNamed("/${value.toString().split(".")[1]}"),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: AppBarState.work,
                  child: Text("Our work"),
                ),
                const PopupMenuItem(
                  value: AppBarState.contact,
                  child: Text("Contact us"),
                ),
              ],
            ),
          ],
        ),
      DeviceType.desktop => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/branding/small_logo.svg",
                height: 48,
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => Modular.to.pushNamed("/"),
                child: Container(
                  color: Colors.transparent,
                  child: const Text(
                    "Dragonfly Labs",
                    style: TextStyle(
                      fontSize: 32,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              _buildButton(
                context: context,
                selected: state == AppBarState.work,
                onPressed: () => Modular.to.pushNamed("/work"),
                title: "Our work",
              ),
              const SizedBox(width: 48),
              _buildButton(
                context: context,
                selected: state == AppBarState.contact,
                onPressed: () => Modular.to.pushNamed("/contact"),
                title: "Contact us",
              ),
            ],
          ),
        ),
    };

    final sigma = scrolled
        ? deviceType == DeviceType.mobile
            ? 16.0
            : 32.0
        : 0.0;

    return SizedBox(
      height: preferredSize.height,
      width: preferredSize.width,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: Container(
            decoration: BoxDecoration(
              color: scrolled
                  ? AppColors.blue.withOpacity(.5)
                  : Colors.transparent,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => deviceType == DeviceType.mobile
      ? const Size.fromHeight(64)
      : const Size.fromHeight(120);
}
