import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terrapedia/controller/country_provider.dart';
import 'package:terrapedia/controller/filter_provider.dart';
import 'package:terrapedia/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CountryDataProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FilterProvider fl = Provider.of<FilterProvider>(context, listen: false);
    var cmPro = Provider.of<CountryDataProvider>(context, listen: false);
    cmPro.fetchData();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
