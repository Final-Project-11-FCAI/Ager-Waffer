import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  final File image;

  const FullScreenImage({super.key, required this.image});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  double scale = 1.0;
  double previousScale = 1.0;

  Offset position = Offset.zero;
  Offset startPosition = Offset.zero;

  /// 🔥 للتحكم في swipe down
  double verticalDrag = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(

        /// 📸 swipe down to close
        onVerticalDragUpdate: (details) {
          setState(() {
            verticalDrag += details.delta.dy;
          });
        },
        onVerticalDragEnd: (details) {
          if (verticalDrag > 150) {
            Navigator.pop(context);
          }
          setState(() {
            verticalDrag = 0;
          });
        },

        /// 🔍 double tap zoom
        onDoubleTap: () {
          setState(() {
            scale = scale == 1.0 ? 2.5 : 1.0;
          });
        },

        child: Center(
          child: Hero(
            tag: widget.image.path,
            child: Transform.translate(
              offset: Offset(0, verticalDrag),
              child: Transform.scale(
                scale: scale,
                child: Image.file(widget.image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}