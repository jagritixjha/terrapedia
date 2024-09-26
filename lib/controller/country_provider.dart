import 'package:flutter/foundation.dart';
import 'package:terrapedia/modal/country_modal.dart';
import 'package:terrapedia/services/api_methods.dart';

class CountryDataProvider extends ChangeNotifier {
  List<dynamic> _fetchedList = [];
  List<CountryModal> countryData = [];

  CountryDataProvider() {
    getData();
  }

  getData() async {
    _fetchedList = await ApiMethods.fetchData();
    countryData = [];
    for (var element in _fetchedList) {
      countryData.add(CountryModal.fromJson(map: element));
    }
    notifyListeners();
  }
}
