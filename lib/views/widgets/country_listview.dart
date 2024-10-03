import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:terrapedia/controller/country_provider.dart';
import 'package:terrapedia/controller/filter_provider.dart';
import 'package:terrapedia/modal/country_modal.dart';
import 'package:terrapedia/views/details_screen.dart';

class CountryListView extends StatelessWidget {
  CountryListView({
    super.key,
    this.savedView = false,
  });
  bool savedView;

  @override
  Widget build(BuildContext context) {
    log('----build called');
    return Expanded(
      child: Consumer<CountryDataProvider>(builder: (context, pro, child) {
        if (pro.isLoading) {
          return const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
                strokeCap: StrokeCap.round,
                strokeWidth: 4,
              ),
            ),
          );
        } else if (savedView
            ? pro.savedCountries.isEmpty
            : pro.countryData.isEmpty) {
          return Center(
            child: Text(
              savedView ? 'No countries saved yet!' : 'No data to show!',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            await pro.fetchData();
          },
          child: ListView.builder(
            itemCount:
                savedView ? pro.savedCountries.length : pro.countryData.length,
            itemBuilder: (context, index) {
              CountryModal cm = savedView
                  ? pro.savedCountries[index]
                  : pro.countryData[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(cm.flagsUrl!['png']),
                ),
                title: Text(
                  cm.name!['common'],
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                subtitle: Text(
                  cm.region!,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    pro.updateSaved(cm);
                  },
                  icon: Icon(
                    cm.isSaved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(country: cm),
                    ),
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
