import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';
import 'package:stockup/models/sales/sale_/sales_model.dart';
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

  String selectedValue = "Filter By Date";
  bool sort = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Text(
                  "Filter",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Spacer(),
                DropdownButton(
                    value: selectedValue,
                    items: <String>[
                      "Filter By Date",
                      "Filter By Price",
                      "Filter By Name"
                    ]
                        .map((element) => DropdownMenuItem<String>(
                            value: element, child: Text(element)))
                        .toList(),
                    onChanged: (selected) {
                      if (selected != null) {
                        setState(() {
                          selectedValue = selected;
                        });
                      }
                    }),
                IconButton(
                    onPressed: () {
                      setState(() {
                        sort = !sort;
                      });
                    },
                    icon: (sort)
                        ? const Icon(Icons.arrow_downward)
                        : const Icon(Icons.arrow_upward)) //sort buttton
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: salenotifier,
            builder: (context, sales, child) {
              List<SalesModel> sorted = List<SalesModel>.from(sales);
              switch (selectedValue) {
                case "Filter By Name":
                  sortByName(sorted);
                  break;
                case "Filter By Price":
                  sortByPrice(sorted);
                  break;
                case "Filter By Date":
                  sortByDate(sorted);
                  break;
              }

              if (!sort) {
                sorted = sortList(sorted);
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: sorted.length,
                  itemBuilder: (context, index) {
                    var sale = sorted[index];
                    var date = ddmmyyyyFormat(sale.saleDate);
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
                                Text(
                                  date,
                                  style: const TextStyle(fontSize: 20),
                                ),
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
