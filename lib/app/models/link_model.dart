enum LinkType {
  appStore("assets/link/appStore.svg", "App Store"),
  playStore("assets/link/playStore.svg", "Play Store"),
  web("assets/link/web.svg", "Web"),
  email("assets/link/email.svg", "Email"),
  github("assets/link/github.svg", "Github"),
  linkedin("assets/link/linkedin.svg", "Linkedin"),
  ;

  final String icon;
  final String title;

  const LinkType(this.icon, this.title);
}

class LinkModel {
  final LinkType type;
  final String url;
  final String? hint;

  const LinkModel({
    required this.type,
    required this.url,
    this.hint,
  });
}
