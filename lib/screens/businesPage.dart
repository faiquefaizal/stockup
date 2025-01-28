import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockup/db_funtions.dart/business_profile.dart';
import 'package:stockup/models/businessprofile/business_profile.dart';

import 'package:stockup/screens/custemwidgets.dart';
import 'package:stockup/screens/profile.dart';

class Businespage extends StatefulWidget {
  Businespage({super.key});

  @override
  State<Businespage> createState() => _BusinespageState();
}

class _BusinespageState extends State<Businespage> {
  @override
  void initState() {
    loadprofile();
    // TODO: implement initState
    super.initState();
  }

  final _key = GlobalKey<FormState>();
  final _shopnamecontroller = TextEditingController();
  final _shopnumbercontroller = TextEditingController();
  final _shopemailcontroller = TextEditingController();
  final _shopaddresscontroller = TextEditingController();

  String? imagepath;

  Future pickimage() async {
    var pickedimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedimage != null) {
      setState(() {
        imagepath = pickedimage.path;
      });
    }
  }

  loadprofile() async {
    var box = await Hive.openBox<BusinessProfile>(BUSINESS_PROFILE_BOX);
    var profile = box.get("profile");
    if (profile != null) {
      _shopnamecontroller.text = profile.shopname;
      _shopnumbercontroller.text = profile.shopnumber;
      _shopemailcontroller.text = profile.shopemail;
      _shopaddresscontroller.text = profile.shopaddress;
      setState(() {
        imagepath = profile.shopimage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Business Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    pickimage();
                  },
                  child: CircleAvatar(
                      radius: 100,
                      backgroundImage: imagepath != null
                          ? FileImage(File(imagepath!))
                          : null,
                      child: imagepath == null
                          ? Center(
                              child: Text("click here to add"),
                            )
                          : null),
                ),
                SizedBox(
                  height: 25,
                ),
                fieledvalidation(_shopnamecontroller, "Business Name", "name",
                    (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter a Name";
                  }
                  if (value.length < 3) {
                    return "Name must be at least 3 characters long";
                  }
                  return null;
                }),
                SizedBox(
                  height: 16,
                ),
                fieledvalidation(
                    _shopnumbercontroller, "Phone Number", "number", (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter a number";
                  }
                  if (value.length != 10) {
                    return "Enter a valid 10-digit phone number";
                  }
                  return null;
                }, inputtype: TextInputType.phone),
                SizedBox(
                  height: 16,
                ),
                fieledvalidation(
                    _shopemailcontroller, "Email", "example@gmail.com",
                    (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter a Email";
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                }, inputtype: TextInputType.emailAddress),
                SizedBox(
                  height: 16,
                ),
                fieledvalidation(
                    _shopaddresscontroller, "Business Address", "adress",
                    (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter a address";
                  }
                  if (value.length < 8) {
                    return "Address must be at least 8 characters long";
                  }
                  return null;
                }, inputtype: TextInputType.emailAddress),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            savebutton(context);
                          }
                        },
                        child: Text("Save details")))
              ],
            ),
          ),
        ),
      ),
    );
  }

  savebutton(BuildContext context) {
    final shopname = _shopnamecontroller.text;
    final shopnumber = _shopnumbercontroller.text;
    final shopemail = _shopemailcontroller.text;
    final shopaddress = _shopaddresscontroller.text;
    final Profile = BusinessProfile(
        shopimage: imagepath!,
        shopname: shopname,
        shopnumber: shopnumber,
        shopemail: shopemail,
        shopaddress: shopaddress);
    addBussinessProfile(Profile);
    Navigator.pop(context);
  }
}
