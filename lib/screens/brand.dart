import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/models/brands/brand_model.dart';
import 'package:stockup/screens/brands_editpage.dart';
import 'package:stockup/screens/custemwidgets.dart';

class Brands extends StatelessWidget {
  Brands({super.key});
  final _brandcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brands"),
      ),
      body: Column(
        children: [
          custemcard("Add Brands", () {
            alertbox(context);
          }),
          custemcard("Edit  Brands", () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const BrandsEditpage()));
          }),
          custemcard("Delete Brands", () {}),
        ],
      ),
    );
  }

  _addButton() {
    var brand = _brandcontroller.text.trim();
    String brandId = DateTime.now().microsecondsSinceEpoch.toString();
    var brandname = BrandModel(brandname: brand, brandId: brandId);

    addBrand(brandname);
  
    _brandcontroller.clear();
  }

  alertbox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Brand"),
            content: field(_brandcontroller, "Brand", "Brand Name"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.black,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () async {
                  await _addButton();
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              )
            ],
          );
        });
  }
}
