// import 'dart:developer';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:stockup/db_funtions.dart/brand_funtions.dart';
// import 'package:stockup/db_funtions.dart/business_profile.dart';
// import 'package:stockup/db_funtions.dart/notification_funtion.dart';
// import 'package:stockup/db_funtions.dart/product_funtion.dart';
// import 'package:stockup/db_funtions.dart/sale_funtion.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   late double totalSales;
//   @override
//   void initState() {
//     log('Called dashboard');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ValueListenableBuilder(
//               valueListenable: salenotifier,
//               builder: (context, value, child) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Dashboard",
//                       style: TextStyle(fontSize: 60, color: Colors.black),
//                     ),
//                     SizedBox(
//                       height: 165,
//                       width: double.infinity,
//                       child: Card(
//                         color: Colors.black,
//                         child: Column(
//                           children: [
//                             const Text("Total Sales"),

//                             // log("totalsale worked");
//                             Text(
//                               "₹${getTotalSales().toString()}",
//                               style: const TextStyle(fontSize: 50),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: SizedBox(
//                             height: 165,
//                             child: Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(15),
//                                 child: Column(
//                                   children: [
//                                     const Text(
//                                       "Items Sold",
//                                       style: TextStyle(fontSize: 27),
//                                     ),
//                                     Text(getTotalnoofproducts().toString(),
//                                         style: const TextStyle(fontSize: 45))
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: SizedBox(
//                             height: 165,
//                             child: Card(
//                               color: Colors.green,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Column(
//                                   children: [
//                                     const Text("Profit"),
//                                     Text(
//                                       getProfit().toString(),
//                                       style: const TextStyle(fontSize: 40),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 25),
//                     AspectRatio(
//                       aspectRatio: 1.5,
//                       child: LineChart(LineChartData(
//                           minX: 0,
//                           maxX: 7,
//                           lineBarsData: [
//                             LineChartBarData(
//                                 color: Colors.black,
//                                 belowBarData: BarAreaData(
//                                     show: true,
//                                     color: const Color.fromARGB(
//                                         221, 157, 155, 155)),
//                                 spots: saleGraphList())
//                           ],
//                           titlesData: FlTitlesData(
//                               show: true,
//                               bottomTitles: AxisTitles(
//                                   axisNameWidget: const Text(
//                                     "Month",
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.black),
//                                   ),
//                                   axisNameSize: 30,
//                                   sideTitles: SideTitles(
//                                     reservedSize: 25,
//                                     interval: 1,
//                                     showTitles: true,
//                                     getTitlesWidget: (value, meta) {
//                                       var labels = getAllSaleDate();
//                                       int index = value.toInt();
//                                       if (index < labels.length) {
//                                         return SideTitleWidget(
//                                           meta: meta,
//                                           child: Text(
//                                             labels[index],
//                                             style: const TextStyle(
//                                                 fontSize: 10,
//                                                 color: Colors.black),
//                                           ),
//                                         );
//                                       }
//                                       return Container();
//                                     },
//                                   )),
//                               leftTitles: AxisTitles(
//                                   sideTitles: SideTitles(
//                                     // interval: 1,

//                                     reservedSize: 40,
//                                     showTitles: true,
//                                     getTitlesWidget: (value, meta) {
//                                       if (value.toInt() <= 50) {
//                                         return SideTitleWidget(
//                                           meta: meta,
//                                           child: const Text(
//                                             "50K",
//                                             style: TextStyle(
//                                                 fontSize: 5,
//                                                 color: Colors.black),
//                                           ),
//                                         );
//                                       } else if (value.toInt() <= 100) {
//                                         return SideTitleWidget(
//                                           meta: meta,
//                                           child: const Text(
//                                             "100K",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.black),
//                                           ),
//                                         );
//                                       } else if (value.toInt() <= 200) {
//                                         return SideTitleWidget(
//                                           meta: meta,
//                                           child: const Text(
//                                             "200K",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.black),
//                                           ),
//                                         );
//                                       } else if (value.toInt() <= 400) {
//                                         return SideTitleWidget(
//                                           meta: meta,
//                                           child: const Text(
//                                             "400K",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.black),
//                                           ),
//                                         );
//                                       }
//                                       // else if (value.toInt() <= 500) {
//                                       //   return SideTitleWidget(
//                                       //     meta: meta,
//                                       //     child: Text(
//                                       //       "500K",
//                                       //       style: TextStyle(
//                                       //           fontSize: 12, color: Colors.black),
//                                       //     ),
//                                       //   );
//                                       // }
//                                       else if (value.toInt() <= 600) {
//                                         return SideTitleWidget(
//                                           meta: meta,
//                                           child: const Text(
//                                             "600K",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.black),
//                                           ),
//                                         );
//                                       }
//                                       // else if (value.toInt() <= 700) {
//                                       //   return SideTitleWidget(
//                                       //     meta: meta,
//                                       //     child: Text(
//                                       //       "700K",
//                                       //       style: TextStyle(
//                                       //           fontSize: 12, color: Colors.black),
//                                       //     ),
//                                       //   );
//                                       // }
//                                       else if (value.toInt() <= 800) {
//                                         return SideTitleWidget(
//                                           meta: meta,
//                                           child: const Text(
//                                             "800K",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.black),
//                                           ),
//                                         );
//                                       }
//                                       // else if (value.toInt() <= 900) {
//                                       //   return SideTitleWidget(
//                                       //     meta: meta,
//                                       //     child: Text(
//                                       //       "900K",
//                                       //       style: TextStyle(
//                                       //           fontSize: 12, color: Colors.black),
//                                       //     ),
//                                       //   );
//                                       // }
//                                       else if (value.toInt() <= 1000) {
//                                         return SideTitleWidget(
//                                           meta: meta,
//                                           child: const Text(
//                                             "10L",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.black),
//                                           ),
//                                         );
//                                       }
//                                       // else {
//                                       //   return SideTitleWidget(
//                                       //     meta: meta,
//                                       //     child: Text(
//                                       //       "${(value / 100000).toInt()}L",
//                                       //       style: TextStyle(
//                                       //           fontSize: 12, color: Colors.black),
//                                       //     ),
//                                       //   );
//                                       // }
//                                       return Container();
//                                     },
//                                   ),
//                                   axisNameWidget: const Text(
//                                     "Total Sales",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 18),
//                                   ),
//                                   axisNameSize: 30)))),
//                     )
//                   ],
//                 );
//               },
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               sample();
//               getBrand();
//               getAllSales();
//               getProducts();
//               getnotification();
//               getProfileData();

//               // getAllSales();
//             },
//             child: const Icon(Icons.refresh),
//           )),
//     );
//   }

//   // List<FlSpot> getsaleGraphList() {
//   //   try {
//   //     return saleGraphList();
//   //   } catch (e, stackTrace) {
//   //     log("Error in saleGraphList: $e");
//   //     log(stackTrace.toString());
//   //     return [];
//   //   }
//   // }
// }

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
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
            valueListenable: salenotifier,
            builder: (context, value, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      " Dashboard",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 165,
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: Colors.deepPurple,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Total Sales",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "₹${getTotalSales().toString()}",
                                style: const TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const Icon(Icons.shopping_cart,
                                      color: Colors.white, size: 35),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Items Sold",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(getTotalnoofproducts().toString(),
                                      style: const TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.green,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const Icon(Icons.trending_up,
                                      color: Colors.white, size: 35),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Profit",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white70),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    getProfit().toString(),
                                    style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: true),
                              minX: 0,
                              maxX: 7,
                              lineBarsData: [
                                LineChartBarData(
                                  color: Colors.deepPurple,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.deepPurple.shade100,
                                  ),
                                  spots: saleGraphList(),
                                )
                              ],
                              titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    axisNameWidget: const Text(
                                      " Month",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
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
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      reservedSize: 40,
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: Text(
                                            "${value.toInt()}K",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        );
                                      },
                                    ),
                                    axisNameWidget: const Text(
                                      "Total Sales",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    axisNameSize: 30,
                                  ),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false))),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
      ),
    );
  }
}
