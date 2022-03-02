class LaunchModel {
  final String rocket;
  final String id;
  final String launchpad;
  final String payloads;
  final String name;
  final String date_utc;
  final int date_unix;
  final Links links;

  LaunchModel({
    required this.rocket,
    required this.id,
    required this.launchpad,
    required this.name,
    required this.date_utc,
    required this.date_unix,
    required this.links,
    required this.payloads,
  });

  factory LaunchModel.fromJson(Map<String, dynamic> json) {
    return LaunchModel(
      rocket: json['rocket'] ?? '',
      id: json['id'] ?? '',
      launchpad: json['launchpad'] ?? '',
      payloads: json['payloads'][0] ?? '',
      name: json['name'] ?? '',
      date_utc: json['date_utc'] ?? '',
      date_unix: json['date_unix'] ?? 0,
      links: Links.fromJson(json['links'] ?? 0),
    );
  }
}

class Links {
  late final String webcast;
  late final String youtube_id;
  late final Patch patch;

  Links.fromJson(Map<String, dynamic> json) {
    webcast = json['webcast'] ?? '';
    youtube_id = json['youtube_id'] ?? '';
    patch = Patch.fromJson(json['patch'] ?? '');
  }
}

class Patch {
  late final String large;

  Patch.fromJson(Map<String, dynamic> json) {
    large = json['large'] ?? '';
  }
}
