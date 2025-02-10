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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: businessprofilenotifier,
                    builder: (context, profile, child) {
                      return Row(
                        children: [
                          CircleAvatar(
                              radius: 25,
                              backgroundImage: profile == null
                                  ? const AssetImage("assets/shopicon.webp")
                                  : FileImage(File(profile.shopimage))),
                          const SizedBox(width: 10),
                          Text(
                            profile?.shopname ?? "Shop Name",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      );
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
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              searchField(_searchfieldcontroller),

              const SizedBox(height: 15),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildChoiceChip("All", "All", -1),
                    ValueListenableBuilder(
                      valueListenable: brandListnotifier,
                      builder: (context, brands, child) {
                        return Row(
                          children: List.generate(
                            brands.length,
                            (index) => _buildChoiceChip(
                                brands[index].brandname, "", index),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Product Grid
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: productsnotifier,
                  builder: (context, productlist, child) {
                    var displaylist = filterproducts;
                    return GridView.builder(
                      itemCount: displaylist.length,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        var product = displaylist[index];
                        var brandname = findBrand(product.brandId);
                        return _buildProductCard(product, brandname, index);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label, String type, int index) {
    bool isSelected = type == "All" ? _selected == "All" : _selected1 == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (type == "All") {
              _selected = "All";
              _selected1 = -1;
            } else {
              _selected1 = index;
              _selected = "";
            }
            _filteredProducts();
          });
        },
        selectedColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        showCheckmark: false,
      ),
    );
  }

  // Custom Widget for Product Card
  Widget _buildProductCard(ProductModel product, String brandname, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            productdetails: product,
            index: index,
            brandname: brandname,
          ),
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        shadowColor: Colors.black26,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: FileImage(File(product.imagePath)),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Brand Name
              customText(text: brandname, size: 12, color: Colors.black54),
              // Product Name
              customText(
                text: product.productame,
                size: 16,
                fonttype: FontWeight.bold,
              ),
              // Price
              customText(
                text: "₹${product.sellingPrice}",
                size: 18,
                color: Colors.green[700]!,
                fonttype: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
