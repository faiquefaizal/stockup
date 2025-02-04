import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/models/businessprofile/business_profile.dart';

const BUSINESS_PROFILE_BOX = "businessprofie";
ValueNotifier<BusinessProfile?> businessprofilenotifier = ValueNotifier(null);

addBussinessProfile(BusinessProfile value) async {
  var profileDb = Hive.box<BusinessProfile>(BUSINESS_PROFILE_BOX);
  await profileDb.put("profile", value);
  log(value.toString());
  getProfileData();
}

void getProfileData() {
  var profileDb = Hive.box<BusinessProfile>(BUSINESS_PROFILE_BOX);
  businessprofilenotifier.value = profileDb.get("profile");
}
