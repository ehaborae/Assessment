class RocketModel {
  final Height height;
  final Height diameter;
  final Mass mass;

  RocketModel({
    required this.height,
    required this.diameter,
    required this.mass,
  });

  factory RocketModel.fromJson(Map<String, dynamic> json) {
    return RocketModel(
      height: Height.fromJson(json['height'] ?? ''),
      diameter: Height.fromJson(json['diameter'] ?? ''),
      mass: Mass.fromJson(json['mass'] ?? ''),
    );
  }
}

class Height {
  late final num meters;
  late final num feet;

  Height({
    required this.meters,
    required this.feet,
  });

  Height.fromJson(Map<String, dynamic> json) {
    meters = json['meters'] ?? 0;
    feet = json['feet'] ?? 0;
  }
}

class Mass {
  late final num kg;
  late final num lb;

  Mass({
    required this.kg,
    required this.lb,
  });

  Mass.fromJson(Map<String, dynamic> json) {
    lb = json['lb'] ?? 0;
    kg = json['kg'] ?? 0;
  }
}
