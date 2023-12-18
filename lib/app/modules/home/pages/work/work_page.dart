import 'package:dragonflylabs/app/design/colors.dart';
import 'package:dragonflylabs/app/models/project_model.dart';
import 'package:dragonflylabs/app/widgets/banners_carousel_widget.dart';
import 'package:dragonflylabs/app/widgets/custom_app_bar.dart';
import 'package:dragonflylabs/app/widgets/interactive_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  final projects = ProjectModel.values;
  final ScrollController _scrollController = ScrollController();
  late final Map<String, FocusNode> _nodes = {
    for (final project in projects) project.id: FocusNode(),
  };

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

  Widget _buildProject(BuildContext context, ProjectModel project,
      {bool imageOnLeft = false}) {
    final device = Device.of(context);
    final reverse = !imageOnLeft && device == DeviceType.desktop;
    final description = Padding(
      padding: device.fold(
        const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
        const EdgeInsets.all(48),
      ),
      child: SelectableRegion(
        focusNode: _nodes[project.id] ?? FocusNode(),
        selectionControls: materialTextSelectionControls,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.name,
              style: TextStyle(
                fontSize: device.fold(24, 48),
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: device.fold(4, 16), width: double.infinity),
            Text(
              project.description,
              style: TextStyle(
                fontSize: device.fold(16, 32),
                color: AppColors.white,
              ),
            ),
            if (project.technologies.isNotEmpty) ...[
              SizedBox(height: device.fold(8, 16)),
              Wrap(
                spacing: 20,
                runSpacing: device.fold(4, 8),
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Technologies:",
                    style: TextStyle(
                      fontSize: device.fold(16, 32),
                      color: AppColors.white,
                    ),
                  ),
                  for (final tech in project.technologies)
                    Tooltip(
                      message: tech.title,
                      child: SvgPicture.asset(
                        tech.icon,
                        height: device.fold(24, 32),
                        width: device.fold(24, 32),
                        colorFilter: const ColorFilter.mode(
                          AppColors.green,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                ],
              ),
            ],
            if (project.links.isNotEmpty) ...[
              SizedBox(height: device.fold(8, 16)),
              Wrap(
                spacing: 16,
                runSpacing: device.fold(4, 8),
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Links:",
                    style: TextStyle(
                      fontSize: device.fold(16, 32),
                      color: AppColors.white,
                    ),
                  ),
                  for (final link in project.links)
                    SizedBox.square(
                      dimension: device.fold(28, 36),
                      child: TextButton(
                        onPressed: () => launchUrlString(link.url),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Center(
                          child: Tooltip(
                            message: link.type.title,
                            child: SvgPicture.asset(
                              link.type.icon,
                              height: device.fold(24, 32),
                              width: device.fold(24, 32),
                              colorFilter: const ColorFilter.mode(
                                AppColors.yellow,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
    var children = [
      if (device == DeviceType.mobile)
        BannersCarouselWidget(
          project.images,
          height: 300,
          width: double.infinity,
        )
      else
        Expanded(
          child: BannersCarouselWidget(
            project.images,
            height: 700,
            width: double.infinity,
          ),
        ),
      if (device == DeviceType.mobile)
        description
      else
        Expanded(child: Center(child: description)),
    ];
    if (reverse) children = children.reversed.toList();
    if (device == DeviceType.desktop) {
      return SizedBox(
        height: 700,
        width: double.infinity,
        child: Row(children: children),
      );
    } else {
      return Column(
        children: children,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveBuilder((context, device) {
      return Scaffold(
        appBar: CustomAppBar(
          AppBarState.work,
          deviceType: device,
          scrolled: _scrolled,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.gradient,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            child: SafeArea(
              child: Column(
                children: [
                  for (final (index, project) in projects.indexed)
                    _buildProject(context, project, imageOnLeft: index % 2 == 0)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
