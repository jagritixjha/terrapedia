import 'package:flutter/foundation.dart';

class FilterProvider extends ChangeNotifier {
  static String _selectedFilter = 'All';
  static String get selectedFilter => _selectedFilter;

  void updateData(String value) {
    _selectedFilter = value;
    notifyListeners();
  }
}
