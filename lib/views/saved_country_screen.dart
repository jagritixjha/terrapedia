import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terrapedia/views/widgets/country_listview.dart';

class SavedCountryScreen extends StatelessWidget {
  const SavedCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Saved Countries',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          CountryListView(
            savedView: true,
          ),
        ],
      ),
    );
  }
}
