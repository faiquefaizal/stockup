import 'package:hive_flutter/hive_flutter.dart';
part 'business_profile.g.dart';

@HiveType(typeId: 0)
class BusinessProfile {
  @HiveField(0)
  String shopname;

  @HiveField(1)
  String shopnumber;

  @HiveField(2)
  String shopemail;

  @HiveField(3)
  String shopaddress;
  @HiveField(4)
  String shopimage;
  BusinessProfile(
      {required this.shopimage,
      required this.shopname,
      required this.shopnumber,
      required this.shopemail,
      required this.shopaddress});
}
