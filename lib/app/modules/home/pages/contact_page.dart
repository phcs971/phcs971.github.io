import 'package:dragonflylabs/app/design/colors.dart';
import 'package:dragonflylabs/app/models/link_model.dart';
import 'package:dragonflylabs/app/widgets/custom_app_bar.dart';
import 'package:dragonflylabs/app/widgets/interactive_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ScrollController _scrollController = ScrollController();

  bool _scrolled = false;
  final node = FocusNode();

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
        aspectRatio: 2 / 3,
        child: SvgPicture.asset(
          "assets/illustrations/contact.svg",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final device = Device.of(context);
    const links = [
      LinkModel(
        type: LinkType.email,
        hint: "phcs.971@gmail.com",
        url: "mailto:phcs.971@gmail.com",
      ),
      LinkModel(
        type: LinkType.github,
        hint: "@phcs971",
        url: "https://github.com/phcs971",
      ),
      LinkModel(
        type: LinkType.linkedin,
        hint: "@phcs971",
        url: "https://www.linkedin.com/in/phcs971/",
      ),
    ];
    return SelectableRegion(
      focusNode: node,
      selectionControls: materialTextSelectionControls,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You can contact us through",
              style: TextStyle(
                fontSize: device.fold(24, 48),
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (final link in links) ...[
              SizedBox(
                height: device.fold(4, 16),
                width: double.infinity,
              ),
              ListTile(
                leading: Tooltip(
                  message: link.type.title,
                  child: SvgPicture.asset(
                    link.type.icon,
                    height: device.fold(24, 48),
                    width: device.fold(24, 48),
                    colorFilter: const ColorFilter.mode(
                      AppColors.yellow,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                title: Text(
                  link.hint ?? link.type.title,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: device.fold(16, 32),
                  ),
                ),
                onTap: () => launchUrlString(link.url),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveBuilder((context, device) {
      return Scaffold(
        appBar: CustomAppBar(
          AppBarState.contact,
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
                          flex: 1,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 700),
                            child: _buildImage(context),
                          ),
                        ),
                        const SizedBox(width: 80),
                        Expanded(
                          flex: 2,
                          child: _buildBody(context),
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
