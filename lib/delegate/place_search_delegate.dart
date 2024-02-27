
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:clima_app/screens/weather_screen.dart';
import 'package:clima_app/models/mapbox_response.dart';
import 'package:clima_app/services/map_box_service.dart';

class PlaceSearchDelegate extends SearchDelegate{

  @override
  final String searchFieldLabel;
  PlaceSearchDelegate(this.searchFieldLabel);


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: const Icon(Icons.clear_outlined)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null), 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if ( query == '') return _ContainerVacio(); 
    
    final mapBoxService = Provider.of<MapBoxService>(context);

    return FutureBuilder(
      future: mapBoxService.searchPlace(query),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasError) return _ContainerVacio();
        if (!snapshot.hasData) return _ContainerVacio();
        return _showPlaces(snapshot.data);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _ContainerVacio();
  }

  Widget _showPlaces(List<Feature> features) {
    return ListView.builder(
      itemCount: features.length,
      itemBuilder: (BuildContext context, int index) {
        final mapBoxService = Provider.of<MapBoxService>(context);
        final feature = features[index];

        return ListTile(
          title: Text(feature.placeName, style: const TextStyle(fontSize: 14), textAlign: TextAlign.justify, maxLines: 2,),
          leading: const Icon(Icons.map, size: 30,),
          onTap: () {
            mapBoxService.featureSelected = feature;
            Navigator.pushNamed(context, WeatherScreen.routeName);
          },
        );
      },
    );
  }

  Widget _ContainerVacio() {
    return const Center(
      child: Text('Search a place..')
    );
  }

}

