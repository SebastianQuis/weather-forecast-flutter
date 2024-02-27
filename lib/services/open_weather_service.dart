import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:clima_app/models/weather_response.dart';


class OpenWeatherService with ChangeNotifier {


  Future<WeatherResponse?> searchWeather(LatLng latLng) async {    
    try {      
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.openweathermap.org',
          queryParameters: {
            'lat': latLng.latitude,
            'lon': latLng.longitude,
            'appid': dotenv.env['WEATHER_API_KEY'],
            'units': 'metric',
            'lang': 'es'
          }
      ));
      
      const url = '/data/2.5/weather';
      final resp = await dio.get(url);
      final weatherResponse = WeatherResponse.fromJson( resp.data );      
      return weatherResponse;
    } catch (e) {
      return null;
    }
  }

}