import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/models/brands/brand_model.dart';
import 'package:stockup/screens/custemwidgets.dart';

class BrandsEditpage extends StatefulWidget {
  const BrandsEditpage({super.key});

  @override
  State<BrandsEditpage> createState() => _BrandsEditpageState();
}

class _BrandsEditpageState extends State<BrandsEditpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _brandeditname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catagories"),
      ),
      body: ValueListenableBuilder(
          valueListenable: brandListnotifier,
          builder: (context, value, child) {
            // print("ValueListenableBuilder called. List size: ${value.length}");
            return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final brand = value[index];
                  return ListTile(
                      title: Text(
                        brand.brandname,
                        style: const TextStyle(fontSize: 30),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Delete it",
                                      style: TextStyle(fontSize: 50),
                                    ),
                                    content: const Text(
                                      "Are you Sure you want to delete It?",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          backgroundColor: Colors.black,
                                          foregroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        onPressed: () {
                                          if (productCheckInBrand(brand)) {
                                            customsnackbar(
                                                context,
                                                "Can't Delete brand  because Products exist",
                                                Colors.red);
                                            return;
                                          }
                                          deleteBrand(index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Delete"),
                                      )
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      onTap: () {
                        alertbox(context, brand);
                      });
                });
          }),
    );
  }

  _editbuttonbutton(BrandModel value) {
    final brand = BrandModel(
        brandname: _brandeditname.text.trim(), brandId: value.brandId);

    var check = brandCheck(brand);
    if (check) {
      customsnackbar(context, "Brand Already Exist", Colors.red);
      return;
    }
    editBrand(brand);
    Navigator.pop(context);
  }

  alertbox(BuildContext context, BrandModel brand) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("edit Brand"),
            content: field(_brandeditname, "Brand", "Brand Name"),
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
                onPressed: () {
                  _editbuttonbutton(brand);
                },
                child: const Text("edit"),
              )
            ],
          );
        });
  }
}
