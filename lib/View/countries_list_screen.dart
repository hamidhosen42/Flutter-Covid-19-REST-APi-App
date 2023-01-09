// ignore_for_file: library_private_types_in_public_api, unused_local_variable, prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/world_virus_view_model.dart';
import 'detail_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WorldVirusViewModel newVirusListViewModel = WorldVirusViewModel();

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // ),
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Search with country name',
                  suffixIcon: searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            searchController.text = "";
                            setState(() {});
                          },
                          child: Icon(Icons.clear)),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: newVirusListViewModel.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    width: 100,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    population:snapshot.data![index]['population'],
                                                    continent:snapshot.data![index]['continent']
                                                  )));
                                    },
                                    child: Card(
                                      shadowColor: Colors.deepPurpleAccent,
                                      color: Colors.grey[200],
                                      child: ListTile(
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag']),
                                        ),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text("Effected: " +
                                            snapshot.data![index]['cases']
                                                .toString()),
                                      ),
                                    ),
                                  ),
                                  // Divider()
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                     population:snapshot.data![index]['population'],
                                                    continent:snapshot.data![index]['continent']
                                                  )));
                                    },
                                    child: Card(
                                      shadowColor: Colors.deepPurpleAccent,
                                      color: Colors.grey[200],
                                      child: ListTile(
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag']),
                                        ),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text("Effected: " +
                                            snapshot.data![index]['cases']
                                                .toString()),
                                      ),
                                    ),
                                  ),
                                  // Divider()
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}