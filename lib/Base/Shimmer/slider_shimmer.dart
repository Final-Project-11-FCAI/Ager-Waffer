import 'package:ager_waffer/Base/common/shared.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/theme.dart';
class SliderSimmer extends StatefulWidget {
  @override
  _SliderSimmerState createState() => _SliderSimmerState();
}

class _SliderSimmerState extends State<SliderSimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: Shared.height * 0.3,
        color: Colors.white,
      ),
    );

  }
}
