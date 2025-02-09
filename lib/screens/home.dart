// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:stockup/db_funtions.dart/brand_funtions.dart';
// import 'package:stockup/db_funtions.dart/business_profile.dart';
// import 'package:stockup/db_funtions.dart/product_funtion.dart';
// import 'package:stockup/models/product/product_model.dart';
// import 'package:stockup/notifications/notification.dart';
// import 'package:stockup/screens/custemwidgets.dart';
// import 'package:stockup/screens/notifications_history.dart';
// import 'package:stockup/screens/product_detail_page.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// final _searchfieldcontroller = TextEditingController();

// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     _searchfieldcontroller.addListener(_filteredProducts);
//     // TODO: implement initState
//     super.initState();
//   }

//   String _selected = "All";
//   int? _selected1;

//   List<ProductModel> filterproducts = productsnotifier.value;
//   void _filteredProducts() {
//     setState(() {
//       filterproducts = productsnotifier.value.where((value) {
//         var brandMatch = _selected == "All" ||
//             (value.brandId == brandListnotifier.value[_selected1!].brandId);
//         var filterbrand = value.productame
//             .toLowerCase()
//             .contains(_searchfieldcontroller.text.toLowerCase());
//         return brandMatch && filterbrand;
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(onPressed: () async {
//           await showNotifcation(title: "check", body: "hdfskjhgkjh");
//         }),
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Row(
//               children: [
//                 ValueListenableBuilder(
//                   valueListenable: businessprofilenotifier,
//                   builder: (context, profile, child) {
//                     if (profile == null) {
//                       return const Text(
//                         "Shop name",
//                         style: TextStyle(color: Colors.black),
//                       );
//                     } else {
//                       return Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: FileImage(File(profile.shopimage)),
//                           ),
//                           Text(
//                             profile.shopname,
//                             style: const TextStyle(color: Colors.black),
//                           ),
//                         ],
//                       );
//                     }
//                   },
//                 ),
//                 const Spacer(),
//                 IconButton(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const NotificationsHistory()));
//                     },
//                     icon: const Icon(
//                       Icons.notifications_active_rounded,
//                       size: 40,
//                     ))
//               ],
//             ),
//             TextField(
//               controller: _searchfieldcontroller,
//               decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   fillColor: Colors.black12,
//                   filled: true,
//                   suffixIcon: Icon(Icons.search),
//                   hintText: "Search"),
//             ),
//             Row(children: [
//               ChoiceChip(
//                 label: Text(
//                   "All",
//                   style: (_selected == "All")
//                       ? const TextStyle(color: Colors.white)
//                       : const TextStyle(color: Colors.black),
//                 ),
//                 selected: _selected == "All",
//                 onSelected: (selected) => setState(() {
//                   _selected = "All";
//                   _selected1 = -1;
//                   _filteredProducts();
//                 }),
//                 selectedColor: Colors.black,
//                 disabledColor: Colors.white,
//                 showCheckmark: false,
//               ),
//               Expanded(
//                 child: ValueListenableBuilder(
//                     valueListenable: brandListnotifier,
//                     builder: (context, brands, child) {
//                       return SizedBox(
//                         height: 50,
//                         child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: brands.length,
//                             itemBuilder: (context, index) {
//                               var brandMatch = brands[index];
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ChoiceChip(
//                                   label: Text(
//                                     brandMatch.brandname,
//                                     style: (_selected1 == index)
//                                         ? const TextStyle(color: Colors.white)
//                                         : const TextStyle(color: Colors.black),
//                                   ),
//                                   selected: _selected1 == index,
//                                   onSelected: (selected) => setState(() {
//                                     if (selected) {
//                                       _selected1 = index;
//                                       _selected = "";
//                                     } else {
//                                       _selected = "All";
//                                       _selected1 = -1;
//                                     }

//                                     _filteredProducts();
//                                   }),
//                                   selectedColor: Colors.black,
//                                   disabledColor: Colors.white,
//                                   showCheckmark: false,
//                                 ),
//                               );
//                             }),
//                       );
//                     }),
//               ),
//             ]),
//             Expanded(
//               child: ValueListenableBuilder(
//                   valueListenable: productsnotifier,
//                   builder: (context, productlist, child) {
//                     var displaylist =
//                         // (_searchfieldcontroller.text.isEmpty)
//                         //     ? productlist
//                         filterproducts;
//                     return GridView.builder(
//                         itemCount: displaylist.length,
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             childAspectRatio: 0.70, crossAxisCount: 2),
//                         itemBuilder: (context, index) {
//                           var product = displaylist[index];
//                           var brandname = findBrand(product.brandId);
//                           return InkWell(
//                             onTap: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (Context) => ProductDetailPage(
//                                         productdetails: product,
//                                         index: index,
//                                         brandname: brandname,
//                                       )));
//                             },
//                             child: Card(
//                               color: const Color.fromARGB(255, 255, 245, 245),
//                               clipBehavior: Clip.hardEdge,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height: 150,
//                                       width: double.infinity,
//                                       child: Image(
//                                           image: FileImage(
//                                               File(product.imagePath)),
//                                           fit: BoxFit.cover),
//                                     ),
//                                     customText(
//                                       text: brandname,
//                                       size: 10,
//                                     ),
//                                     customText(
//                                         text: product.productame, size: 20),
//                                     customText(
//                                         text:
//                                             "₹${product.sellingPrice.toString()}",
//                                         size: 25)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         });
//                   }),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:stockup/db_funtions.dart/brand_funtions.dart';
// import 'package:stockup/db_funtions.dart/business_profile.dart';
// import 'package:stockup/db_funtions.dart/product_funtion.dart';
// import 'package:stockup/models/product/product_model.dart';
// import 'package:stockup/notifications/notification.dart';
// import 'package:stockup/screens/custemwidgets.dart';
// import 'package:stockup/screens/notifications_history.dart';
// import 'package:stockup/screens/product_detail_page.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// final _searchfieldcontroller = TextEditingController();

// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     _searchfieldcontroller.addListener(_filteredProducts);
//     super.initState();
//   }

//   String _selected = "All";
//   int? _selected1;
//   List<ProductModel> filterproducts = productsnotifier.value;

//   void _filteredProducts() {
//     setState(() {
//       filterproducts = productsnotifier.value.where((value) {
//         var brandMatch = _selected == "All" ||
//             (value.brandId == brandListnotifier.value[_selected1!].brandId);
//         var filterbrand = value.productame
//             .toLowerCase()
//             .contains(_searchfieldcontroller.text.toLowerCase());
//         return brandMatch && filterbrand;
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.black,
//           onPressed: () async {
//             await showNotifcation(title: "Check", body: "Notification Test");
//           },
//           child: const Icon(Icons.notifications, color: Colors.white),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with Shop Info
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color.fromARGB(221, 203, 146, 146), Colors.black54],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius:
//                     BorderRadius.only(bottomLeft: Radius.circular(30)),
//               ),
//               child: Row(
//                 children: [
//                   ValueListenableBuilder(
//                     valueListenable: businessprofilenotifier,
//                     builder: (context, profile, child) {
//                       return Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 25,
//                             backgroundImage: profile == null
//                                 ? const AssetImage('assets/default_shop.png')
//                                     as ImageProvider
//                                 : FileImage(File(profile.shopimage)),
//                           ),
//                           const SizedBox(width: 10),
//                           Text(
//                             profile?.shopname ?? "Shop Name",
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   const Spacer(),
//                   IconButton(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 const NotificationsHistory()));
//                       },
//                       icon: const Icon(
//                         Icons.notifications_active_rounded,
//                         size: 35,
//                         color: Colors.white,
//                       )),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Search Bar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: TextField(
//                 controller: _searchfieldcontroller,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.all(15),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   suffixIcon: const Icon(Icons.search, color: Colors.black54),
//                   hintText: "Search for products...",
//                   hintStyle: const TextStyle(color: Colors.black45),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),

//             // Brand Selection Chips
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 children: [
//                   ChoiceChip(
//                     label: Text(
//                       "All",
//                       style: TextStyle(
//                           color:
//                               _selected == "All" ? Colors.white : Colors.black),
//                     ),
//                     selected: _selected == "All",
//                     onSelected: (selected) {
//                       setState(() {
//                         _selected = "All";
//                         _selected1 = -1;
//                         _filteredProducts();
//                       });
//                     },
//                     selectedColor: Colors.black,
//                     backgroundColor: Colors.white,
//                     showCheckmark: false,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                   ),
//                   const SizedBox(width: 10),
//                   ValueListenableBuilder(
//                     valueListenable: brandListnotifier,
//                     builder: (context, brands, child) {
//                       return Row(
//                         children: List.generate(brands.length, (index) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 5),
//                             child: ChoiceChip(
//                               label: Text(
//                                 brands[index].brandname,
//                                 style: TextStyle(
//                                     color: _selected1 == index
//                                         ? Colors.white
//                                         : Colors.black),
//                               ),
//                               selected: _selected1 == index,
//                               onSelected: (selected) {
//                                 setState(() {
//                                   if (selected) {
//                                     _selected1 = index;
//                                     _selected = "";
//                                   } else {
//                                     _selected = "All";
//                                     _selected1 = -1;
//                                   }
//                                   _filteredProducts();
//                                 });
//                               },
//                               selectedColor: Colors.black,
//                               backgroundColor: Colors.white,
//                               showCheckmark: false,
//                               elevation: 3,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15)),
//                             ),
//                           );
//                         }),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Product Grid
//             Expanded(
//               child: ValueListenableBuilder(
//                   valueListenable: productsnotifier,
//                   builder: (context, productlist, child) {
//                     var displaylist = filterproducts;
//                     return GridView.builder(
//                         padding: const EdgeInsets.all(10),
//                         itemCount: displaylist.length,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10,
//                                 mainAxisSpacing: 10,
//                                 childAspectRatio: 0.75),
//                         itemBuilder: (context, index) {
//                           var product = displaylist[index];
//                           var brandname = findBrand(product.brandId);
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (Context) => ProductDetailPage(
//                                         productdetails: product,
//                                         index: index,
//                                         brandname: brandname,
//                                       )));
//                             },
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15)),
//                               elevation: 5,
//                               shadowColor:
//                                   const Color.fromARGB(66, 255, 255, 255),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: const BorderRadius.vertical(
//                                         top: Radius.circular(15)),
//                                     child: Image.file(File(product.imagePath),
//                                         height: 140,
//                                         width: double.infinity,
//                                         fit: BoxFit.cover),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         customText(text: brandname, size: 12),
//                                         customText(
//                                             text: product.productame,
//                                             size: 18,
//                                             fonttype: FontWeight.bold),
//                                         customText(
//                                             text: "₹${product.sellingPrice}",
//                                             size: 22,
//                                             fonttype: FontWeight.bold)
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         });
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
        backgroundColor: Colors.grey[100],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () async {
            await showNotifcation(title: "Check", body: "Notification test");
          },
          child: const Icon(Icons.notifications, color: Colors.black),
        ),
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
                                  ? const AssetImage(
                                      "assets/default_profile.png")
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
                      color: Colors.black54,
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
              Expanded(
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
