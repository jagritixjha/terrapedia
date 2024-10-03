import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:terrapedia/controller/filter_provider.dart';
import 'package:terrapedia/modal/country_modal.dart';
import 'package:terrapedia/services/api_methods.dart';
import 'package:terrapedia/services/local_storage.dart';

class CountryDataProvider extends ChangeNotifier {
  List<CountryModal> countryData = [];
  List<CountryModal> savedCountries = [];
  bool isLoading = true;
  String fl = 'All';

  CountryDataProvider() {
    fetchData();
  }

  fetchData() async {
    try {
      List<dynamic> fetchedList = await ApiMethods.fetchData();
      fl = FilterProvider.selectedFilter;
      countryData = [];
      savedCountries = [];

      for (var i in fetchedList) {
        CountryModal temp = CountryModal.fromJson(map: i);

        if (fl == 'Dependent' && !temp.isIndependent!) {
          countryData.add(temp);
        } else if (fl == 'Independent' && temp.isIndependent!) {
          countryData.add(temp);
        } else if (fl == 'All') {
          countryData.add(temp);
        }
        await fetchSavedList(temp);
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      log('Error fetching data: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  fetchSavedList(CountryModal temp) async {
    try {
      List<String>? savedList = await LocalStorage.fetchSaved();

      if (savedList != null && savedList.contains(temp.name!['common'])) {
        temp.isSaved = true;
        savedCountries.add(temp);
      }
    } catch (e) {
      log('Error fetching saved list: $e');
    }
  }

  void updateSaved(CountryModal country) {
    int indexOfCountry = countryData.indexOf(country);
    if (savedCountries.contains(country)) {
      countryData[indexOfCountry].isSaved = false;
      LocalStorage.removeSaved(countryName: country.name!['common']);
    } else {
      countryData[indexOfCountry].isSaved = true;
      LocalStorage.saveCountry(countryName: country.name!['common']);
    }
    fetchData();
    notifyListeners();
  }

/*  --------------- Another approach

  void addToSaved(CountryModal country) {
    int indexOfCountry = countryData.indexOf(country);
    countryData[indexOfCountry].isSaved = true;
    LocalStorage.saveCountry(countryName: country.name!['common']);
    fetchData();
    isAdded = false;
    notifyListeners();
  }

  void removeFromSaved(CountryModal country) {
    int indexOfCountry = countryData.indexOf(country);
    countryData[indexOfCountry].isSaved = false;
    LocalStorage.removeSaved(countryName: country.name!['common']);
    fetchData();
    isRemoved = false;
    notifyListeners();
  }*/
}
