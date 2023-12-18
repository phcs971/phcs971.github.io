import 'package:dragonflylabs/app/design/colors.dart';
import 'package:dragonflylabs/app/widgets/custom_app_bar.dart';
import 'package:dragonflylabs/app/widgets/interactive_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && !_scrolled) {
        setState(() => _scrolled = true);
      } else if (_scrollController.offset == 0 && _scrolled) {
        setState(() => _scrolled = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildImage(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 551 / 480,
        child: SvgPicture.asset(
          "assets/illustrations/developer.svg",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final device = Device.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Engineering Solutions",
            style: TextStyle(
              fontSize: device.fold(24, 48),
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: device.fold(4, 16),
            width: double.infinity,
          ),
          Text(
            "Our lab develops specific solutions for any problem you might have. We specialize in different areas, like mobile development, system automations, and sports technologies.",
            style: TextStyle(
              fontSize: device.fold(16, 32),
              color: AppColors.white,
            ),
          ),
          SizedBox(
            height: device.fold(16, 32),
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: device.fold(
              MainAxisAlignment.center,
              MainAxisAlignment.start,
            ),
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: device.fold(16, 24),
                    horizontal: 24,
                  ),
                  shape: const RoundedRectangleBorder(),
                  textStyle: TextStyle(
                    fontSize: device.fold(14, 24),
                  ),
                ),
                onPressed: () => Modular.to.pushNamed("/work"),
                child: const Text("Our work"),
              ),
              const SizedBox(width: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.white.withOpacity(.1),
                  padding: EdgeInsets.symmetric(
                    vertical: device.fold(16, 24),
                    horizontal: 24,
                  ),
                  shape: const RoundedRectangleBorder(),
                  textStyle: TextStyle(
                    fontSize: device.fold(14, 24),
                  ),
                ),
                onPressed: () => Modular.to.pushNamed("/contact"),
                child: const Text("Contact us"),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveBuilder((context, device) {
      return Scaffold(
        appBar: CustomAppBar(
          AppBarState.home,
          deviceType: device,
          scrolled: _scrolled,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.blue,
          child: switch (device) {
            DeviceType.desktop => SingleChildScrollView(
                controller: _scrollController,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 64, bottom: 64),
                    child: Row(
                      children: [
                        const SizedBox(width: 80),
                        Expanded(
                          child: _buildBody(context),
                        ),
                        const SizedBox(width: 80),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 450),
                            child: _buildImage(context),
                          ),
                        ),
                        const SizedBox(width: 80),
                      ],
                    ),
                  ),
                ),
              ),
            DeviceType.mobile => SingleChildScrollView(
                controller: _scrollController,
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(64, 16, 64, 0),
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: _buildImage(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                        child: _buildBody(context),
                      ),
                    ],
                  ),
                ),
              ),
          },
        ),
      );
    });
  }
}
