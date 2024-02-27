import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:clima_app/widgets/search_place_button.dart';
import 'package:clima_app/widgets/custom_title_text.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final Color colorSeleccionado;
  final Color colorSecundario;
  final double dotPrimario;
  final double dotSecundario;

  const SlideShow({super.key, 
    required this.slides, 
    this.colorSeleccionado = Colors.black, 
    this.colorSecundario = Colors.black45, 
    this.dotPrimario = 15, 
    this.dotSecundario = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ )  =>  _SlidesProvider(),
      child: Builder( 
        builder: (BuildContext context) { 
          Provider.of<_SlidesProvider>(context).colorSeleccionado = colorSeleccionado;
          Provider.of<_SlidesProvider>(context).colorSecundario   = colorSecundario;
          Provider.of<_SlidesProvider>(context).dotPrimario       = dotPrimario;
          Provider.of<_SlidesProvider>(context).dotSecundario     = dotSecundario;

          return _BodySlides(
            slides: slides,
          );
        },
      ),
    );
  }
}

class _BodySlides extends StatefulWidget {
  const _BodySlides({
    required this.slides,
  });

  final List<Widget> slides;

  @override
  State<_BodySlides> createState() => _BodySlidesState();
}

class _BodySlidesState extends State<_BodySlides> {
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Column(
        children: [

          const CustomTitleText('Weather forecast'),

          Expanded(
            child: _Slides( widget.slides )
          ),

          _Dots( widget.slides.length),

          const SearchPlaceButton(title: 'Search a place'),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;
  const _Dots( this.totalSlides );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (index) => _Dot(index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final slidesProvider = Provider.of<_SlidesProvider>(context);
    Color color;
    double tamanio;

    if ( slidesProvider.paginaActual >= index - 0.5 && slidesProvider.paginaActual < index + 0.5 ) {
      color = slidesProvider.colorSeleccionado;
      tamanio = slidesProvider.dotPrimario;
    } else {
      color = slidesProvider.colorSecundario;
      tamanio = slidesProvider.dotSecundario;
    }
    
    return AnimatedContainer(
      duration: const Duration( milliseconds: 200 ),
      width: tamanio, // .rectangle + 5
      height: tamanio,
      margin: const EdgeInsets.symmetric( horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides( this.slides );
  
  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final controller = PageController();

  @override
  void initState() {
    controller.addListener(() {
      Provider.of<_SlidesProvider>(context, listen: false).paginaActual = controller.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: widget.slides.map((slide) => _Slide( slide )).toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  const _Slide(this.slide);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      child: slide
    );
  }
}

class _SlidesProvider with ChangeNotifier{

  double _paginaActual     = 0;
  Color _colorSeleccionado = Colors.red;
  Color _colorSecundario   = Colors.green;
  double _dotPrimario      = 15;
  double _dotSecundario    = 12;
  
  double get paginaActual => _paginaActual;
  set paginaActual( double pagina ) {
    _paginaActual = pagina;
    notifyListeners();
  }

  Color get colorSeleccionado => _colorSeleccionado;
  set colorSeleccionado( Color color ) => _colorSeleccionado = color;
  
  Color get colorSecundario => _colorSecundario;
  set colorSecundario( Color color ) => _colorSecundario = color;

  double get dotPrimario => _dotPrimario;
  set dotPrimario( double tamanio ) => _dotPrimario = tamanio;

  double get dotSecundario => _dotSecundario;
  set dotSecundario( double tamanio ) => _dotSecundario = tamanio;
}