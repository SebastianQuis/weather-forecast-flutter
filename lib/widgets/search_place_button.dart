import 'package:flutter/material.dart';

import 'package:clima_app/delegate/place_search_delegate.dart';

class SearchPlaceButton extends StatelessWidget {
  final String title;
  
  const SearchPlaceButton({
    super.key, 
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only( bottom: 20),
      width: 300,
      height: 50,
      child: TextButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.black87),
        ),
        onPressed: () async {
          await showSearch(context: context, delegate: PlaceSearchDelegate('Search...'));
        }, 
        child: Text(title, style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}