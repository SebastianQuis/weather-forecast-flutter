import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:clima_app/models/mapbox_response.dart';


class MapBoxService with ChangeNotifier {
  Feature? featureSelected;

  Future<List<Feature>> searchPlace(String place) async {
    try {      
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.mapbox.com/geocoding/v5',
          queryParameters: {
            'language': 'es',
            'access_token': dotenv.env['MAPBOX_API_KEY'],
          }
      ));
      
      final url = '/mapbox.places/$place.json';
      
      final resp = await dio.get(url);
      
      final mapBoxResponse = MapBoxResponse.fromJson( resp.data );      
      return mapBoxResponse.features; 
    } catch (e) {
      return [];
    }
  }

}
