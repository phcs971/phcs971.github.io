import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/utils.dart';
import '../../../models/models.dart';

class ProjectText extends StatelessWidget {
  final Project project;
  const ProjectText(this.project, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String statusString = kStatusToString[project.status!]!;
    if (project.status != Status.tostart && project.start != null) {
      statusString += " (Início: ${DateFormat('MM/yyyy').format(project.start!)}";
      if (project.status == Status.closed && project.end != null)
        statusString += ", Fim: ${DateFormat('MM/yyyy').format(project.end!)})";
      else
        statusString += ")";
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(statusString),
          SizedBox(height: 25),
          Text(
            "Projeto ${kCauseToString[project.cause!]}. ${project.description}",
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 25),
          Text("Tecnologias:"),
          for (var t in project.techs!) Text("   \u2022 ${kTechToString[t]}"),
          if (project.links != null && project.links!.isNotEmpty) ...[
            SizedBox(height: 25),
            Text("Links:"),
            SingleChildScrollView(
              child: Row(
                children: project.links!
                    .map((link) => IconButton(
                          icon: Icon(kLinkToIcon[link.type], color: project.mainColor),
                          tooltip: kLinkToString[link.type],
                          onPressed: () async {
                            try {
                              await launch(link.url!);
                            } catch (_) {
                              cannotLaunchUrl(context);
                            }
                          },
                        ))
                    .toList(),
              ),
            )
          ]
        ],
      ),
    );
  }
}
