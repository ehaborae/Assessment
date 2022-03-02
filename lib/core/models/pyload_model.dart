class PayloadModel {
  final String name;
  final String type;

  PayloadModel({
    required this.name,
    required this.type,
  });

  factory PayloadModel.fromJson(Map<String, dynamic> json) {
    return PayloadModel(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
