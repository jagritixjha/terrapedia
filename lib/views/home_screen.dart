import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:terrapedia/controller/country_provider.dart';
import 'package:terrapedia/controller/filter_provider.dart';
import 'package:terrapedia/views/saved_country_screen.dart';
import 'package:terrapedia/views/widgets/country_listview.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<String> filterList = [
    'All',
    'Independent',
    'Dependent',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Terrapedia',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedCountryScreen(),
                  ));
            },
            tooltip: 'view saved',
            icon: const Icon(
              Icons.bookmark_border_rounded,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Countries to explore',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Consumer<FilterProvider>(
                  builder: (context, pro, child) => DropdownButton(
                    value: FilterProvider.selectedFilter,
                    items: [
                      ...List.generate(
                        filterList.length,
                        (index) => DropdownMenuItem(
                          value: filterList[index],
                          child: Text(
                            filterList[index],
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    isDense: true,
                    borderRadius: BorderRadius.circular(12),
                    onChanged: (value) {
                      pro.updateData(
                        value!,
                      );
                      Provider.of<CountryDataProvider>(context, listen: false)
                          .fetchData();
                    },
                  ),
                ),
              ],
            ),
          ),
          CountryListView()
        ],
      ),
    );
  }
}
