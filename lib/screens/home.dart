import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/business_profile.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/screens/custemwidgets.dart';
import 'package:stockup/screens/product_detail_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final _searchfieldcontroller = TextEditingController();

class _HomeState extends State<Home> {
  @override
  void initState() {
    getProfileData();
    getProducts();
    getBrand();
    getAllSales();
    _searchfieldcontroller.addListener(_filteredText);
    // TODO: implement initState
    super.initState();
  }

  List<ProductModel> filterproducts = [];
  void _filteredText() {
    setState(() {
      filterproducts = productsnotifier.value.where((value) {
        return value.productame
            .toLowerCase()
            .contains(_searchfieldcontroller.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: businessprofilenotifier,
                  builder: (context, profile, child) {
                    if (profile == null) {
                      return Text(
                        "Shop name",
                        style: TextStyle(color: Colors.black),
                      );
                    } else {
                      return Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: FileImage(File(profile.shopimage)),
                          ),
                          Text(
                            profile.shopname,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      );
                    }
                  },
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_active_rounded,
                      size: 40,
                    ))
              ],
            ),
            TextField(
              controller: _searchfieldcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black12,
                  filled: true,
                  suffixIcon: Icon(Icons.search),
                  hintText: "Search"),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: productsnotifier,
                  builder: (context, productlist, child) {
                    var displaylist = (_searchfieldcontroller.text.isEmpty)
                        ? productlist
                        : filterproducts;
                    return GridView.builder(
                        itemCount: displaylist.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.70, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          var product = displaylist[index];
                          var brandname = findBrand(product.brandId);
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (Context) => ProductDetailPage(
                                        productdetails: product,
                                        index: index,
                                        brandname: brandname,
                                      )));
                            },
                            child: Card(
                              color: const Color.fromARGB(255, 255, 245, 245),
                              clipBehavior: Clip.hardEdge,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      child: Image(
                                          image: FileImage(
                                              File(product.imagePath)),
                                          fit: BoxFit.cover),
                                    ),
                                    customText(
                                      text: brandname,
                                      size: 10,
                                    ),
                                    customText(
                                        text: product.productame, size: 20),
                                    customText(
                                        text:
                                            "₹${product.sellingPrice.toString()}",
                                        size: 25)
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
