import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/models/businessprofile/business_profile.dart';

const BUSINESS_PROFILE_BOX = "businessprofie";
ValueNotifier<BusinessProfile?> businessprofilenotifier = ValueNotifier(null);

addBussinessProfile(BusinessProfile value) async {
  var profile_db = await Hive.openBox<BusinessProfile>(BUSINESS_PROFILE_BOX);
  await profile_db.put("profile", value);
  print(value);
}

void getProfileData() async {
  var profile_db = await Hive.openBox<BusinessProfile>(BUSINESS_PROFILE_BOX);
  businessprofilenotifier.value = profile_db.get("profile");
}
