import 'package:dragonflylabs/app/models/link_model.dart';

enum TechnologyEnum {
  swift("assets/tech/swift.svg", "Swift"),
  flutter("assets/tech/flutter.svg", "Flutter"),
  dart("assets/tech/dart.svg", "Dart"),
  ios("assets/tech/ios.svg", "iOS"),
  android("assets/tech/android.svg", "Android"),
  firebase("assets/tech/firebase.svg", "Firebase"),
  github("assets/tech/github.svg", "Github"),
  agile("assets/tech/agile.svg", "Agile Framework"),
  ;

  final String icon;
  final String title;

  const TechnologyEnum(this.icon, this.title);
}

class ProjectModel {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final List<LinkModel> links;
  final List<TechnologyEnum> technologies;
  final DateTime startedAt;
  final DateTime? finishedAt;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.links,
    required this.technologies,
    required this.startedAt,
    this.finishedAt,
  });

  static final values = [
    ProjectModel(
      id: "1",
      name: "market4u",
      description:
          "Honest market app. Go to the market in the confort of your home.",
      images: [
        "assets/projects/market4u/mk4u_1.jpeg",
      ],
      links: [
        const LinkModel(
          type: LinkType.appStore,
          url: "https://apps.apple.com/br/app/market4u/id1497298079",
        ),
        const LinkModel(
          type: LinkType.playStore,
          url:
              "https://play.google.com/store/apps/details?id=br.com.mobile.market4u",
        ),
      ],
      technologies: [
        TechnologyEnum.flutter,
        TechnologyEnum.dart,
        TechnologyEnum.firebase,
        TechnologyEnum.ios,
        TechnologyEnum.android,
        TechnologyEnum.agile,
        TechnologyEnum.github,
      ],
      startedAt: DateTime(2023, 1),
    ),
    ProjectModel(
      id: "2",
      name: "Podi",
      description:
          "Companion app for shopping mall clients. Help clients with manage parking, movies and discounts.",
      images: [
        "assets/projects/podi/podi_1.png",
        "assets/projects/podi/podi_2.jpeg",
      ],
      links: [
        const LinkModel(
          type: LinkType.appStore,
          url: "https://apps.apple.com/br/app/podi/id1519317433",
        ),
        const LinkModel(
          type: LinkType.playStore,
          url:
              "https://play.google.com/store/apps/details?id=br.com.podiapp.podi",
        ),
      ],
      technologies: [
        TechnologyEnum.flutter,
        TechnologyEnum.dart,
        TechnologyEnum.firebase,
        TechnologyEnum.ios,
        TechnologyEnum.android,
        TechnologyEnum.agile,
        TechnologyEnum.github,
      ],
      startedAt: DateTime(2020, 9),
      finishedAt: DateTime(2022, 7),
    ),
  ];
}
