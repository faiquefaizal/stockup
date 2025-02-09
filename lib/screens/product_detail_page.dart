import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/screens/custemwidgets.dart';
import 'package:stockup/screens/editItem.dart';

class ProductDetailPage extends StatelessWidget {
  // final Map<String, dynamic> productdetail;
  final int index;
  final ProductModel productdetails;
  final String brandname;
  const ProductDetailPage(
      {super.key,
      required this.productdetails,
      required this.index,
      required this.brandname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    File(productdetails.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                productdetails.productame,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "₹${productdetails.sellingPrice.toString()}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(text: "Brand:"),
                        customText(text: "Ram:"),
                        customText(text: "color:"),
                        customText(text: "Storage:"),
                        customText(text: "os:"),
                        customText(text: "screenSize:"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(text: brandname, fonttype: FontWeight.bold),
                        customText(
                            text: productdetails.ram,
                            fonttype: FontWeight.bold),
                        customText(
                            text: productdetails.color,
                            fonttype: FontWeight.bold),
                        customText(
                            text: productdetails.storage,
                            fonttype: FontWeight.bold),
                        customText(
                            text: productdetails.os, fonttype: FontWeight.bold),
                        customText(
                            text: productdetails.screenSize,
                            fonttype: FontWeight.bold),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 80,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: Colors.grey.shade600,
                  ),
                  child: TextButton(
                    child: const Text(
                      "Edit Product",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Edititem(index: index)));
                    },
                  )),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 80,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    "Add to Sale",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
// {
//                                           "name": product.productame,
//                                           "price": product.sellingPrice,
//                                           "Ram": product.ram,
//                                           "color": product.color,
//                                           "storage": product.storage,
//                                           "os": product.os,
//                                           "screensize": product.screenSize,
//                                           "Brand": product.brandId,
//                                           "image": product.imagePath
//                                         },
