import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/screens/additemspage.dart';
import 'package:stockup/screens/custemwidgets.dart';
import 'package:stockup/screens/editItem.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headText(text: "Items"),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: productsnotifier,
                  builder: (context, productlist, child) {
                    return ListView.builder(
                        itemCount: productlist.length,
                        itemBuilder: (context, index) {
                          var product = productlist[index];
                          var brandname = findBrand(product.brandId);
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (Context) =>
                                        Edititem(index: index)));
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      height: 60,
                                      width: 50,
                                      File(product.imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(brandname),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.productame,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Qty: ${product.quatity.toString()}",
                                          style: (product.quatity > 5)
                                              ? const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20)
                                              : const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20),
                                        )
                                      ]),
                                  trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  "Delete it",
                                                  style:
                                                      TextStyle(fontSize: 50),
                                                ),
                                                content: const Text(
                                                  "Are you Sure you want to delete It?",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      backgroundColor:
                                                          Colors.black,
                                                      foregroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                    ),
                                                    onPressed: () async {
                                                      await deleteProduct(
                                                          index);
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
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const Additemspage();
            }));
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _deletebutton(int index, BuildContext context) async {
    await deleteProduct(index);
    Navigator.pop(context);
  }
}
