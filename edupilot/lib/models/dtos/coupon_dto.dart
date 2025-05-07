class CouponDTO {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int fee;

  CouponDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.fee,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'fee': fee,
    };
  }
  factory CouponDTO.fromJson(Map<String, dynamic> json) {
    return CouponDTO(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      fee: json['fee'],
    );
  }
}