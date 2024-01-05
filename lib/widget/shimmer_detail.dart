import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDetailPage extends StatelessWidget {
  const ShimmerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
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
                    height: 8,
                  ),
                  // Shimmer effect for the restaurant name
                  Container(
                    height: 20,
                    width: 200,
                    color: Colors.grey[300]!,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Shimmer effect for the location
                  Container(
                    height: 16,
                    width: 150,
                    color: Colors.grey[300]!,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Shimmer effect for the rating
                  Container(
                    height: 16,
                    width: 60,
                    color: Colors.grey[300]!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Shimmer effect for the description
                  Container(
                    height: 80,
                    color: Colors.grey[300]!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Shimmer effect for the menu sections
                  _buildShimmerMenuSection(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildShimmerMenuSection(),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildShimmerMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shimmer effect for the menu section title
        Container(
          height: 20,
          width: 100,
          color: Colors.grey[300]!,
        ),
        const SizedBox(
          height: 8,
        ),
        // Shimmer effect for the menu items
        for (int i = 0; i < 3; i++) // Adjust the count based on your design
          Container(
            height: 16,
            width: 120,
            color: Colors.grey[300]!,
            margin: const EdgeInsets.only(bottom: 4),
          ),
      ],
    );
  }
}
