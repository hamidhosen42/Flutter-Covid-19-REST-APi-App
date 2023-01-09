// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name, continent;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test,
      population;

  DetailScreen(
      {required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,
      required this.population,
      required this.continent});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Image.network(
                      widget.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Card(
                      child: Column(
                        children: [
                          ReusableRow(
                            title: 'Continent',
                            value: widget.continent.toString(),
                          ),
                          Divider(),
                          ReusableRow(
                            title: 'population',
                            value: widget.population.toString(),
                          ),
                          Divider(),
                          ReusableRow(
                            title: 'Cases',
                            value: widget.totalCases.toString(),
                          ),
                          Divider(),
                          ReusableRow(
                            title: 'Recovered',
                            value: widget.totalRecovered.toString(),
                          ),
                          Divider(),
                          ReusableRow(
                            title: 'Death',
                            value: widget.totalDeaths.toString(),
                          ),
                          Divider(),
                          ReusableRow(
                            title: 'Critical',
                            value: widget.critical.toString(),
                          ),
                          Divider(),
                          ReusableRow(
                            title: 'Today Recovered',
                            value: widget.totalRecovered.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              Text(value, style: TextStyle(fontSize: 15.sp))
            ],
          ),
        ],
      ),
    );
  }
}