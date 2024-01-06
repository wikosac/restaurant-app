import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 84,
                width: 120,
                color: Colors.grey[300]!,
                margin: const EdgeInsets.only(bottom: 4),
              ),
              const SizedBox(
                height: 8,
              ),
              // Shimmer effect for the rating
              Container(
                height: 14,
                width: 60,
                color: Colors.grey[300]!,
              ),
              const SizedBox(
                height: 8,
              ),
              // Shimmer effect for the rating
              Container(
                height: 14,
                width: 60,
                color: Colors.grey[300]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
