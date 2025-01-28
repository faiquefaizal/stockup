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

  TextEditingController _brandeditname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getBrand();
    return Scaffold(
      appBar: AppBar(
        title: Text("Catagories"),
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
                        style: TextStyle(fontSize: 30),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Delete it",
                                      style: TextStyle(fontSize: 50),
                                    ),
                                    content: Text(
                                      "Are you Sure you want to delete It?",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
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
                                          deleteBrand(index);
                                        },
                                        child: Text("Delete"),
                                      )
                                    ],
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      onTap: () {
                        alertbox(context, index);
                      });
                });
          }),
    );
  }

  _editbuttonbutton(int index) {
    final brand = _brandeditname.text.trim();
    editBrand(index, brand);
  }

  alertbox(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("edit Brand"),
            content: field(_brandeditname, "Brand", "Brand Name"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
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
                  await _editbuttonbutton(index);
                  Navigator.pop(context);
                },
                child: Text("edit"),
              )
            ],
          );
        });
  }
}
