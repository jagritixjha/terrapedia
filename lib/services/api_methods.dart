import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiMethods {
  static Future<List> fetchData() async {
    Uri uri = Uri.parse(
        'https://restcountries.com/v3.1/all?_gl=1*y919ss*_ga*Nzk1ODA1MzA2LjE3MDE5NDYyMTM.*_ga_ZCYG64C7PL*MTcyNzI2ODUxNy4xMi4xLjE3MjcyNjg3NDIuMC4wLjA.');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse is List<dynamic>) {
        return decodedResponse;
      } else {
        return [];
      }
    }
    return [];
  }
}
