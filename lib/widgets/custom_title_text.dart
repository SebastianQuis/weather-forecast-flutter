import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  final String title;
  const CustomTitleText(
    this.title, 
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only( top: 20),
      child: Text(title, style: const TextStyle(color: Colors.indigo, fontSize: 40, fontWeight: FontWeight.w800),)
    );
  }
}