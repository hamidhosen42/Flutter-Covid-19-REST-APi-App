// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_field, annotate_overrides, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_covid_19_app/Model/world_states.dart';
import 'package:flutter_covid_19_app/Services/world_virus_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'countries_list_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 5), vsync: this)
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

  WorldVirusViewModel newVirusListViewModel = WorldVirusViewModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                FutureBuilder(
                    future: newVirusListViewModel.fetchWorldRecords(),
                    builder:
                        (context, AsyncSnapshot<WorldVirusModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                              ),
                              SpinKitFadingCircle(
                                color: Colors.deepPurple,
                                size: 50.0,
                                controller: _controller,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Card(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: PieChart(
                                  dataMap: {
                                    "Total": double.parse(
                                        snapshot.data!.cases!.toString()),
                                    "Recovered": double.parse(
                                        snapshot.data!.recovered.toString()),
                                    "Deaths": double.parse(
                                        snapshot.data!.deaths.toString()),
                                  },
                                  animationDuration:
                                      Duration(milliseconds: 1200),
                                  chartLegendSpacing: 35,
                                  chartRadius: 150.w,
                                  colorList: colorList,
                                  initialAngleInDegree: 0,
                                  chartType: ChartType.ring,
                                  ringStrokeWidth: 20,
                                  legendOptions: const LegendOptions(
                                    showLegendsInRow: false,
                                    legendPosition: LegendPosition.right,
                                    showLegends: true,
                                    legendTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValueBackground: true,
                                    showChartValues: true,
                                    showChartValuesInPercentage: true,
                                    showChartValuesOutside: false,
                                    decimalPlaces: 2,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Card(
                                color: Colors.grey[200],
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ReusableRow(
                                          title: 'Total population',
                                          value: snapshot.data!.population
                                              .toString()),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ReusableRow(
                                          title: 'Total Cases',
                                          value:
                                              snapshot.data!.cases.toString()),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ReusableRow(
                                          title: 'Deaths',
                                          value:
                                              snapshot.data!.deaths.toString()),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ReusableRow(
                                          title: 'Recovered',
                                          value: snapshot.data!.recovered
                                              .toString()),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ReusableRow(
                                          title: 'Active',
                                          value:
                                              snapshot.data!.active.toString()),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ReusableRow(
                                          title: 'Critical',
                                          value: snapshot.data!.critical
                                              .toString()),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ReusableRow(
                                          title: 'Today Deaths',
                                          value: snapshot.data!.todayDeaths
                                              .toString()),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ReusableRow(
                                          title: 'Today Recovered',
                                          value: snapshot.data!.todayRecovered
                                              .toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CountriesListScreen()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Track Countries',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 15.sp),
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}