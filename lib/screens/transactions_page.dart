import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/screens/sale_edit_page.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    getAllSales();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Transaction History"),
        ),
        body: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: salenotifier,
                builder: (context, sales, child) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: sales.length,
                        itemBuilder: (context, index) {
                          var sale = sales[index];
                          return Card(
                            color: Colors.black.withValues(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("#${index + 1}"),
                                      Text(
                                        "Consumer Name: ${sale.custumerName}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                          "No of Products: ${sale.productCount}",
                                          style: TextStyle(fontSize: 20)),
                                      Text(
                                          "Total Sale : ${sale.totalSalePrice} Rs",
                                          style: TextStyle(fontSize: 22)),
                                    ],
                                  ),
                                  Spacer(),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: DropdownButton<String>(
                                          icon: Icon(Icons.menu),
                                          items: ["Edit", "Delete"]
                                              .map((element) =>
                                                  DropdownMenuItem<String>(
                                                      value: element,
                                                      child: Text(element)))
                                              .toList(),
                                          onChanged: (String? seletedvalue) {
                                            if (seletedvalue == "Delete") {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        "Delete it",
                                                        style: TextStyle(
                                                            fontSize: 50),
                                                      ),
                                                      content: Text(
                                                        "Are you Sure you want to delete It?",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            backgroundColor:
                                                                Colors.black,
                                                            foregroundColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                          ),
                                                          onPressed: () {
                                                            deleteSale(index);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("Delete"),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            } else if (seletedvalue == "Edit") {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SaleEditPage(
                                                              index: index)));
                                            }
                                          })),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                })
          ],
        ));
  }
}
