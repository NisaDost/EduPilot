class ClaimedCouponDTO {
  final String id;
  final String couponName;
  final String couponIcon;
  final String couponDescription;
  final String code;
  final bool isUsed;
  final DateTime claimedDate;
  final DateTime expirationDate;

  ClaimedCouponDTO({
    required this.id,
    required this.couponName,
    required this.couponIcon,
    required this.couponDescription,
    required this.code,
    required this.isUsed,
    required this.claimedDate,
    required this.expirationDate,
  });

  factory ClaimedCouponDTO.fromJson(Map<String, dynamic> json) {
    return ClaimedCouponDTO(
      id: json['id'] as String,
      couponName: json['couponName'] as String,
      couponIcon: json['couponIcon'] as String,
      couponDescription: json['couponDescription'] as String,
      code: json['code'] as String,
      isUsed: json['isUsed'] as bool,
      claimedDate: DateTime.parse(json['claimedDate'] as String),
      expirationDate: DateTime.parse(json['expirationDate'] as String),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'couponName': couponName,
      'couponIcon': couponIcon,
      'couponDescription': couponDescription,
      'code': code,
      'isUsed': isUsed,
      'claimedDate': claimedDate.toIso8601String(),
      'expirationDate': expirationDate.toIso8601String(),
    };
  }
}