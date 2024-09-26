import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:terrapedia/controller/country_provider.dart';
import 'package:terrapedia/modal/country_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terrapedia',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            'Countries to explore',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Consumer<CountryDataProvider>(
              builder: (context, pro, child) => ListView.builder(
                itemCount: pro.countryData.length,
                itemBuilder: (context, index) {
                  CountryModal cm = pro.countryData[index];
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
                      ), add.
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
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
