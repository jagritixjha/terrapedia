import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:terrapedia/controller/country_provider.dart';
import 'package:terrapedia/modal/country_modal.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key, required this.country});
  CountryModal country;

  List<Map<String, dynamic>> get countryDetails => [
        {'Common Name': country.name!['common'] ?? 'NA'},
        {'Official name': country.name!['official'] ?? 'NA'},
        {'Region': country.region ?? 'NA'},
        {'Sub-region': country.subRegion ?? 'NA'},
        {
          'Country Status':
              country.isIndependent! ? 'Independent' : 'Not Independent'
        },
        {'Start of week': country.startOfWeek ?? 'NA'},
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          country.name!['common'],
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          Consumer<CountryDataProvider>(
            builder: (context, pro, child) => IconButton(
              onPressed: () => pro.updateSaved(country),
              icon: Icon(
                country.isSaved
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Image.network(
                country.flagsUrl!['png'],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              itemCount: countryDetails.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> details = countryDetails[index];
                return Card(
                  color: Colors.indigo.shade50,
                  shadowColor: Colors.indigo.shade50,
                  child: ListTile(
                    title: Text(
                      details.keys.first,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      details.values.first,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo.shade700,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
