import 'package:flutter/cupertino.dart';

class ImagePlacholderWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/images/placeholder.png',
        fit: BoxFit.cover,
      ),
    );
  }

}