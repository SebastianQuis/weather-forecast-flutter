import 'package:flutter/material.dart';

import 'package:clima_app/widgets/slideshow.dart';
 
class SlidesShowScreen extends StatelessWidget {
  static const routeName = 'SlidesShowScreen';
  const SlidesShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    
    return const Scaffold(
      body: SlideShow(
      slides: [
        Image(image: AssetImage('assets/weather-1.png'), filterQuality: FilterQuality.high, fit: BoxFit.fitWidth,),
        Image(image: AssetImage('assets/weather-2.png'), filterQuality: FilterQuality.high, fit: BoxFit.fitWidth,),
        Image(image: AssetImage('assets/weather-3.png'), filterQuality: FilterQuality.high, fit: BoxFit.fitWidth,),
        Image(image: AssetImage('assets/weather-4.png'), filterQuality: FilterQuality.high, fit: BoxFit.fitWidth,),
      ]
    )
    );
  }
}

