import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:clima_app/models/weather_response.dart';
import 'package:clima_app/services/map_box_service.dart';
import 'package:clima_app/services/open_weather_service.dart';


class WeatherScreen extends StatelessWidget {
  static const routeName = 'ClimaScreen';

  const WeatherScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final center = Provider.of<MapBoxService>(context).featureSelected!.center;
    final openWeatherService = Provider.of<OpenWeatherService>(context);

    return Scaffold(
      body: FutureBuilder(
        future: openWeatherService.searchWeather(LatLng(center.last, center.first)),
        builder: (_, AsyncSnapshot<WeatherResponse?> snapshot) {
          if( snapshot.hasError ) return const Center(child: CircularProgressIndicator(),);
          if( !snapshot.hasData ) return const Center(child: CircularProgressIndicator(),);
          
          return _WeatherBody(snapshot.data!);
        },
      ),      
    );
  }
}


class _WeatherBody extends StatelessWidget {
  final WeatherResponse weatherResponse; 

  const _WeatherBody(this.weatherResponse);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        _BackgroundImage(weatherResponse),
        
        _WeatherInformationBotton(weatherResponse),

      ],
    );
  }
}


class _BackgroundImage extends StatelessWidget {
  final WeatherResponse weatherResponse;

  const _BackgroundImage( this.weatherResponse );

  @override
  Widget build(BuildContext context) {
    final featureSelected = Provider.of<MapBoxService>(context).featureSelected;
    final size = MediaQuery.of(context).size;
    
    return SizedBox(
      height: size.height *0.7,
      width: double.infinity,
      child: Stack(
        children: [
          
          Positioned(
            top: weatherResponse.main!.temp! < 15.0 ? 0 : 50,
            right: weatherResponse.main!.temp! < 15.0 ? -50 : -70,
            child: SizedBox(
              height: size.height * 0.5,
              child: FadeInRight(
                duration: Duration(milliseconds: 1200),
                from: 25,
                child: Image(
                  image: AssetImage(
                      weatherResponse.main!.temp! < 15.0
                        ? 'assets/winter.png'
                        : 'assets/summer.png'
                      ), // 
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: FadeInLeft(
                duration: const Duration(milliseconds: 1500),
                from: 25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BoxLocation(),
                    _TitleText(description: featureSelected!.textEs, colors: Colors.black, fontSize: 40,),
                    _TitleText(description: ' ${weatherResponse.sys!.country!}', colors: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal,),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}


class _BoxLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: const _TitleText(description: 'Your location', fontSize: 15, colors: Colors.white,),
    );
  }
}


class _WeatherInformationBotton extends StatelessWidget {

  final WeatherResponse weatherResponse;

  const _WeatherInformationBotton( this.weatherResponse );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final now = DateTime.now();
    String dayName = DateFormat('EEEE').format(now);
    
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height * 0.5,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff1b263b),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
    
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [                
                _TitleText(description: '${weatherResponse.weather![0].main}',),
                _TitleText(description: '$dayName ${now.day.toString()}', colors: Colors.white60),
              ],
            ),

            SizedBox(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TitleText(description: '${weatherResponse.main!.temp!.round()}', fontSize: 80,),
                  const _TitleText(description: '0C', fontSize: 28,),
                ],
              ),
            ),

            const Divider(color: Colors.grey),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  from: 25,
                  child: _TypeInformation(
                    fontAwesome: FontAwesomeIcons.wind,
                    colors: Colors.indigo,
                    porcentage: '${weatherResponse.wind!.speed! } m/s',
                    typeValue: 'wind',
                  ),
                ),

                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  from: 35,
                  child: _TypeInformation(
                    fontAwesome: FontAwesomeIcons.eyeLowVision,
                    colors: Colors.blueGrey,
                    porcentage: '${weatherResponse.visibility! / 1000} km',
                    typeValue: 'Visibility',
                  ),
                ),

                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  from: 45,
                  child: _TypeInformation( 
                    fontAwesome: FontAwesomeIcons.droplet,
                    colors: Colors.blue,
                    porcentage: '${weatherResponse.main!.humidity}%',
                    typeValue: 'Humidity',
                  ),
                ),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}


class _TypeInformation extends StatelessWidget {
  final IconData fontAwesome;
  final String porcentage;
  final String typeValue;
  final Color colors;
  const _TypeInformation({
    required this.fontAwesome, 
    required this.porcentage, 
    required this.colors, 
    required this.typeValue
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(blurRadius: 2, offset: Offset(0.9, 0.9))
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(fontAwesome, size: 25, color: colors),
          const SizedBox(height: 10),
          _TitleText(description: porcentage, fontSize: 20, colors: Colors.black,),
          Text(typeValue, style: const TextStyle(fontSize: 18, color: Colors.black45))
        ],
      ),
    );
  }
}


class _TitleText extends StatelessWidget {
  final String description;
  final double fontSize;
  final Color colors;
  final FontWeight fontWeight;
  
  const _TitleText({
    required this.description, 
    this.fontSize = 25, 
    this.colors = Colors.white, 
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Text(description, style: TextStyle(color: colors, fontSize: fontSize, fontWeight: fontWeight),);
  }
}