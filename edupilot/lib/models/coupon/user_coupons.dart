import 'package:edupilot/models/coupon/coupon.dart';
import 'package:edupilot/models/user/user.dart';

class UserCoupons {
  UserCoupons({
    required this.id,
    required this.user,
    required this.coupon,
    required this.qrCode,
    required this.isUsed,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final User user;
  final Coupon coupon;
  final String qrCode;
  bool isUsed = false;
  final DateTime createdAt;
  late DateTime updatedAt;
}