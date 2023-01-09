// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_field, annotate_overrides, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

import 'countries_list_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Colors.deepPurple,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .06),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: PieChart(
                        dataMap: {
                          "Total": 20,
                          "Recovered": 15,
                          "Deaths": 5,
                        },
                        chartType: ChartType.ring,
                        chartLegendSpacing: 35.w,
                        animationDuration: Duration(milliseconds: 1200),
                        chartRadius: 150.w,
                        colorList: colorList,
                        ringStrokeWidth: 25,
                        initialAngleInDegree: 0,
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                          decimalPlaces: 2,
                        ),
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // ReusableRow(
                    //     title: 'Total Cases',
                    //     value: snapshot.data!.cases.toString()),
                    // ReusableRow(
                    //     title: 'Deaths', value: snapshot.data!.deaths.toString()),
                    // ReusableRow(
                    //     title: 'Recovered',
                    //     value: snapshot.data!.recovered.toString()),
                    // ReusableRow(
                    //     title: 'Active', value: snapshot.data!.active.toString()),
                    // ReusableRow(
                    //     title: 'Critical',
                    //     value: snapshot.data!.critical.toString()),
                    // ReusableRow(
                    //     title: 'Today Deaths',
                    //     value: snapshot.data!.todayDeaths.toString()),
                    // ReusableRow(
                    //     title: 'Today Recovered',
                    //     value: snapshot.data!.todayRecovered.toString()),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CountriesListScreen()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    'Track Countries',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(
            height: 5.h,
          ),
          Divider()
        ],
      ),
    );
  }
}
