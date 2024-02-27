import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:clima_app/screens/weather_screen.dart';
import 'package:clima_app/screens/slideshow_screen.dart';
import 'package:clima_app/services/map_box_service.dart';
import 'package:clima_app/services/open_weather_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MapBoxService()),
      ChangeNotifierProvider(create: (context) => OpenWeatherService()),
    ],
    child: const MyApp()) 
  );
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast App',
      home: const SlidesShowScreen(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        SlidesShowScreen.routeName: (context) => const SlidesShowScreen(), 
        WeatherScreen.routeName   : (context) => const WeatherScreen(), 
      },
    );
  }
}