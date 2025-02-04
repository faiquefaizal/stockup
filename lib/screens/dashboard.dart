import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/business_profile.dart';
import 'package:stockup/db_funtions.dart/notification_funtion.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/db_funtions.dart/sale_funtion.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late double totalSales;
  @override
  void initState() {
    log('Called dashboard');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
              valueListenable: salenotifier,
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dashboard",
                      style: TextStyle(fontSize: 60, color: Colors.black),
                    ),
                    SizedBox(
                      height: 165,
                      width: double.infinity,
                      child: Card(
                        color: Colors.black,
                        child: Column(
                          children: [
                            const Text("Total Sales"),

                            // log("totalsale worked");
                            Text(
                              "₹${getTotalSales().toString()}",
                              style: const TextStyle(fontSize: 50),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 165,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Items Sold",
                                      style: TextStyle(fontSize: 27),
                                    ),
                                    Text(getTotalnoofproducts().toString(),
                                        style: const TextStyle(fontSize: 45))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 165,
                            child: Card(
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const Text("Profit"),
                                    Text(
                                      getProfit().toString(),
                                      style: const TextStyle(fontSize: 40),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: LineChart(LineChartData(
                          minX: 0,
                          maxX: 7,
                          lineBarsData: [
                            LineChartBarData(
                                color: Colors.black,
                                belowBarData: BarAreaData(
                                    show: true,
                                    color: const Color.fromARGB(
                                        221, 157, 155, 155)),
                                spots: saleGraphList())
                          ],
                          titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                  axisNameWidget: const Text(
                                    "Month",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  axisNameSize: 30,
                                  sideTitles: SideTitles(
                                    reservedSize: 25,
                                    interval: 1,
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      var labels = getAllSaleDate();
                                      int index = value.toInt();
                                      if (index < labels.length) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: Text(
                                            labels[index],
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),
                                        );
                                      }
                                      return Container();
                                    },
                                  )),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    // interval: 1,

                                    reservedSize: 40,
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() <= 50) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: const Text(
                                            "50K",
                                            style: TextStyle(
                                                fontSize: 5,
                                                color: Colors.black),
                                          ),
                                        );
                                      } else if (value.toInt() <= 100) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: const Text(
                                            "100K",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        );
                                      } else if (value.toInt() <= 200) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: const Text(
                                            "200K",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        );
                                      } else if (value.toInt() <= 400) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: const Text(
                                            "400K",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        );
                                      }
                                      // else if (value.toInt() <= 500) {
                                      //   return SideTitleWidget(
                                      //     meta: meta,
                                      //     child: Text(
                                      //       "500K",
                                      //       style: TextStyle(
                                      //           fontSize: 12, color: Colors.black),
                                      //     ),
                                      //   );
                                      // }
                                      else if (value.toInt() <= 600) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: const Text(
                                            "600K",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        );
                                      }
                                      // else if (value.toInt() <= 700) {
                                      //   return SideTitleWidget(
                                      //     meta: meta,
                                      //     child: Text(
                                      //       "700K",
                                      //       style: TextStyle(
                                      //           fontSize: 12, color: Colors.black),
                                      //     ),
                                      //   );
                                      // }
                                      else if (value.toInt() <= 800) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: const Text(
                                            "800K",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        );
                                      }
                                      // else if (value.toInt() <= 900) {
                                      //   return SideTitleWidget(
                                      //     meta: meta,
                                      //     child: Text(
                                      //       "900K",
                                      //       style: TextStyle(
                                      //           fontSize: 12, color: Colors.black),
                                      //     ),
                                      //   );
                                      // }
                                      else if (value.toInt() <= 1000) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: const Text(
                                            "10L",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        );
                                      }
                                      // else {
                                      //   return SideTitleWidget(
                                      //     meta: meta,
                                      //     child: Text(
                                      //       "${(value / 100000).toInt()}L",
                                      //       style: TextStyle(
                                      //           fontSize: 12, color: Colors.black),
                                      //     ),
                                      //   );
                                      // }
                                      return Container();
                                    },
                                  ),
                                  axisNameWidget: const Text(
                                    "Total Sales",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  axisNameSize: 30)))),
                    )
                  ],
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              sample();
              getBrand();
              getAllSales();
              getProducts();
              getnotification();
              getProfileData();

              // getAllSales();
            },
            child: const Icon(Icons.refresh),
          )),
    );
  }

  // List<FlSpot> getsaleGraphList() {
  //   try {
  //     return saleGraphList();
  //   } catch (e, stackTrace) {
  //     log("Error in saleGraphList: $e");
  //     log(stackTrace.toString());
  //     return [];
  //   }
  // }
}
