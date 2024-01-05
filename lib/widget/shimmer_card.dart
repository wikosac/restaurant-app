import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 4,
              blurRadius: 2,
              offset: Offset(2, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer effect for the image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.grey[300]!,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            // Shimmer effect for the restaurant name
            Container(
              height: 20,
              color: Colors.grey[300]!,
            ),
            const SizedBox(
              height: 8,
            ),
            // Shimmer effect for the star icon and rating
            Container(
              height: 16,
              width: 60,
              color: Colors.grey[300]!,
            ),
          ],
        ),
      ),
    );
  }
}
