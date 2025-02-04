
import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/screens/sale_edit_page.dart';

import 'custemwidgets.dart';

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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text("Transaction History"),
  //       ),
  //       body: Column(
  //         children: [
  //           ValueListenableBuilder(
  //               valueListenable: salenotifier,
  //               builder: (context, sales, child) {
  //                 return Expanded(
  //                   child: ListView.builder(
  //                       itemCount: sales.length,
  //                       itemBuilder: (context, index) {
  //                         var sale = sales[index];
  //                         return Card(
  //                           color: Colors.black.withValues(),
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.end,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Column(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text("#${index + 1}"),
  //                                     Text(
  //                                       "Consumer Name: ${sale.custumerName}",
  //                                       style: TextStyle(fontSize: 20),
  //                                     ),
  //                                     Text(
  //                                         "No of Products: ${sale.productCount}",
  //                                         style: TextStyle(fontSize: 20)),
  //                                     Text(
  //                                         "Total Sale : ${sale.totalSalePrice} Rs",
  //                                         style: TextStyle(fontSize: 22)),
  //                                   ],
  //                                 ),
  //                                 Spacer(),
  //                                 Positioned(
  //                                     top: 0,
  //                                     right: 0,
  //                                     child: DropdownButton<String>(
  //                                         icon: Icon(Icons.menu),
  //                                         items: ["Edit", "Delete"]
  //                                             .map((element) =>
  //                                                 DropdownMenuItem<String>(
  //                                                     value: element,
  //                                                     child: Text(element)))
  //                                             .toList(),
  //                                         onChanged: (String? seletedvalue) {
  //                                           if (seletedvalue == "Delete") {
  //                                             showDialog(
  //                                                 context: context,
  //                                                 builder: (context) {
  //                                                   return AlertDialog(
  //                                                     title: Text(
  //                                                       "Delete it",
  //                                                       style: TextStyle(
  //                                                           fontSize: 50),
  //                                                     ),
  //                                                     content: Text(
  //                                                       "Are you Sure you want to delete It?",
  //                                                       style: TextStyle(
  //                                                           color:
  //                                                               Colors.black),
  //                                                     ),
  //                                                     actions: [
  //                                                       TextButton(
  //                                                           onPressed: () {
  //                                                             Navigator.pop(
  //                                                                 context);
  //                                                           },
  //                                                           child: Text(
  //                                                             "Cancel",
  //                                                             style: TextStyle(
  //                                                                 color: Colors
  //                                                                     .black),
  //                                                           )),
  //                                                       ElevatedButton(
  //                                                         style: ElevatedButton
  //                                                             .styleFrom(
  //                                                           shape: RoundedRectangleBorder(
  //                                                               borderRadius:
  //                                                                   BorderRadius
  //                                                                       .circular(
  //                                                                           10)),
  //                                                           backgroundColor:
  //                                                               Colors.black,
  //                                                           foregroundColor:
  //                                                               const Color
  //                                                                   .fromARGB(
  //                                                                   255,
  //                                                                   255,
  //                                                                   255,
  //                                                                   255),
  //                                                         ),
  //                                                         onPressed: () {
  //                                                           deleteSale(
  //                                                               sale.saleId);
  //                                                           Navigator.pop(
  //                                                               context);
  //                                                         },
  //                                                         child: Text("Delete"),
  //                                                       )
  //                                                     ],
  //                                                   );
  //                                                 });
  //                                           } else if (seletedvalue == "Edit") {
  //                                             Navigator.of(context).push(
  //                                                 MaterialPageRoute(
  //                                                     builder: (context) =>
  //                                                         SaleEditPage(
  //                                                             index: index)));
  //                                           }
  //                                         })),
  //                               ],
  //                             ),
  //                           ),
  //                         );
  //                       }),
  //                 );
  //               })
  //         ],
  //       ));

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
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
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("#${index + 1}"),
                                Text(
                                  "Consumer Name: ${sale.custumerName}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "No of Products: ${sale.productCount}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "Total Sale : ${sale.totalSalePrice} Rs",
                                  style: const TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem<String>(
                                  value: "Edit",
                                  child: Text("Edit"),
                                ),
                                const PopupMenuItem<String>(
                                  value: "Delete",
                                  child: Text("Delete"),
                                ),
                              ],
                              onSelected: (String selectedValue) {
                                if (selectedValue == "Delete") {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) => AlertDialog(
                                  //     title: const Text(
                                  //       "Delete it",
                                  //       style: TextStyle(fontSize: 50),
                                  //     ),
                                  //     content: const Text(
                                  //       "Are you Sure you want to delete It?",
                                  //       style: TextStyle(color: Colors.black),
                                  //     ),
                                  //     actions: [
                                  //       TextButton(
                                  //         onPressed: () =>
                                  //             Navigator.pop(context),
                                  //         child: const Text("Cancel"),
                                  //       ),
                                  //       ElevatedButton(
                                  //         style: ElevatedButton.styleFrom(
                                  //           shape: RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10),
                                  //           ),
                                  //           backgroundColor: Colors.black,
                                  //           foregroundColor: Colors.white,
                                  //         ),
                                  //         onPressed: () {
                                  //           deleteSale(sale.saleId);
                                  //           Navigator.pop(context);
                                  //         },
                                  //         child: const Text("Delete"),
                                  //       )
                                  //     ],
                                  //   ),
                                  // );
                                  CustumAlertDialog(
                                    title: "Delete It",
                                    context: context,
                                    subtitle:
                                        "Are you Sure you want to delete It?",
                                    yesButton: "Delete",
                                    noButton: "Cancel",
                                    yesonPressed: () {
                                      deleteSale(sale.saleId);
                                      Navigator.pop(context);
                                    },
                                    noonpressed: () => Navigator.pop(context),
                                  );
                                } else if (selectedValue == "Edit") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SaleEditPage(index: index),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
