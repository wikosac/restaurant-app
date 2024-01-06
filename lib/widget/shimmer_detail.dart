import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDetailPage extends StatelessWidget {
  const ShimmerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          // Shimmer effect for the image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16.0)),
            child: Container(
              height: 270,
              color: Colors.grey[300]!,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer effect for the title
                Container(
                  height: 24,
                  width: 100,
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
                  height: 16,
                ),
                // Shimmer effect for the description
                Column(
                  children: [
                    Container(
                      height: 10,
                      color: Colors.grey[300]!,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 10,
                      color: Colors.grey[300]!,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 10,
                      color: Colors.grey[300]!,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                // Shimmer effect for the menu sections
                _buildShimmerMenuSection(),
                const SizedBox(
                  height: 14,
                ),
                _buildShimmerMenuSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shimmer effect for the menu section title
        Container(
          height: 16,
          width: 100,
          color: Colors.grey[300]!,
        ),
        Row(
          children: [
            // Shimmer effect for the menu items
            for (int i = 0; i < 3; i++) // Adjust the count based on your design
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey[300]!,
                      margin: const EdgeInsets.only(bottom: 4),
                    ),
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}
