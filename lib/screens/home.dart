import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/business_profile.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/notifications/notification.dart';
import 'package:stockup/screens/custemwidgets.dart';
import 'package:stockup/screens/notifications_history.dart';
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
    _searchfieldcontroller.addListener(_filteredProducts);
    // TODO: implement initState
    super.initState();
  }

  String _selected = "All";
  int? _selected1;

  List<ProductModel> filterproducts = productsnotifier.value;
  void _filteredProducts() {
    setState(() {
      filterproducts = productsnotifier.value.where((value) {
        var brandMatch = _selected == "All" ||
            (value.brandId == brandListnotifier.value[_selected1!].brandId);
        var filterbrand = value.productame
            .toLowerCase()
            .contains(_searchfieldcontroller.text.toLowerCase());
        return brandMatch && filterbrand;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          await showNotifcation(title: "check", body: "hdfskjhgkjh");
        }),
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
                      return const Text(
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
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationsHistory()));
                    },
                    icon: const Icon(
                      Icons.notifications_active_rounded,
                      size: 40,
                    ))
              ],
            ),
            TextField(
              controller: _searchfieldcontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black12,
                  filled: true,
                  suffixIcon: Icon(Icons.search),
                  hintText: "Search"),
            ),
            Row(children: [
              ChoiceChip(
                label: Text(
                  "All",
                  style: (_selected == "All")
                      ? const TextStyle(color: Colors.white)
                      : const TextStyle(color: Colors.black),
                ),
                selected: _selected == "All",
                onSelected: (selected) => setState(() {
                  _selected = "All";
                  _selected1 = -1;
                  _filteredProducts();
                }),
                selectedColor: Colors.black,
                disabledColor: Colors.white,
                showCheckmark: false,
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: brandListnotifier,
                    builder: (context, brands, child) {
                      return SizedBox(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: brands.length,
                            itemBuilder: (context, index) {
                              var brandMatch = brands[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChoiceChip(
                                  label: Text(
                                    brandMatch.brandname,
                                    style: (_selected1 == index)
                                        ? const TextStyle(color: Colors.white)
                                        : const TextStyle(color: Colors.black),
                                  ),
                                  selected: _selected1 == index,
                                  onSelected: (selected) => setState(() {
                                    if (selected) {
                                      _selected1 = index;
                                      _selected = "";
                                    } else {
                                      _selected = "All";
                                      _selected1 = -1;
                                    }

                                    _filteredProducts();
                                  }),
                                  selectedColor: Colors.black,
                                  disabledColor: Colors.white,
                                  showCheckmark: false,
                                ),
                              );
                            }),
                      );
                    }),
              ),
            ]),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: productsnotifier,
                  builder: (context, productlist, child) {
                    var displaylist =
                        // (_searchfieldcontroller.text.isEmpty)
                        //     ? productlist
                        filterproducts;
                    return GridView.builder(
                        itemCount: displaylist.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    SizedBox(
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
