import 'dart:convert';

import '../Model/world_states.dart';
import 'package:http/http.dart' as http;

class WorldVirusViewModel {
  Future<WorldVirusModel> fetchWorldRecords() async {
    final response =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldVirusModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}

Future<List<dynamic>> countriesListApi() async {
  final response = await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    return data;
  } else {
    throw Exception('Error');
  }
}