import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowFullImageScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ShowFullImageScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ShowFullImageScreen> createState() => _ShowFullImageScreenState();
}

class _ShowFullImageScreenState extends State<ShowFullImageScreen> {
  late PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    controller = PageController(
      initialPage: currentIndex,
      viewportFraction: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            physics: const BouncingScrollPhysics(), // smoother swipe
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              final image = widget.images[index];
              return Hero(
                tag: image,
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "${currentIndex + 1} / ${widget.images.length}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}