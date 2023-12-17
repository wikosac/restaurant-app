import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  const MyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          title: Container(
            width: 24,
            height: 16,
            color: Colors.white,
          ),
          subtitle: Container(
            width: 16,
            height: 12,
            color: Colors.white,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              color: Colors.white,
              width: 64,
              height: 64,
            ),
          ),
        ),
      );
    }
}
