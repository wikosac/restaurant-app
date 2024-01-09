import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/shimmer_card.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Selamat datang!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                    color: lightColorScheme.primaryContainer,
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.person,
                    )),
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/makanan.jpg'),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Rekomendasi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _buildList(context),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8),
              child: Text(
                'Kuliner',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 84, child: _buildCulinary()),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/makanan.jpg')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return SizedBox(
            height: 192,
            child: ListView.builder(
                itemCount: 5,
                itemExtent: 150,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const ShimmerCard();
                }),
          );
        } else if (state.state == ResultState.hasData) {
          final data = state.restaurantResult.restaurants;
          return SizedBox(
            height: 192,
            child: ListView.builder(
              itemExtent: 150,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                var restaurant = data[index];
                return _buildCard(context, restaurant);
              },
            ),
          );
        } else if (state.state == ResultState.noData) {
          return SizedBox(height: 120, child: Center(child: Text(state.message)));
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        }
        return SizedBox(
          height: 180,
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const Expanded(child: ShimmerCard());
              }),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant.id);
      },
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
                Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      // Show a placeholder image from a local asset when loading fails
                      return Center(
                        child: Image.asset(
                          'assets/icon.png',
                          // Replace with the path to your local asset image
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        restaurant.rating.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCulinary() {
    final List<String> culinary = [
      'Manis',
      'Gurih',
      'Kuah',
      'Camilan',
      'Bakar',
      'Goreng'
    ];
    return ListView.builder(
        itemExtent: 84,
        scrollDirection: Axis.horizontal,
        itemCount: culinary.length,
        itemBuilder: (context, index) {
          return _buildItem(context, culinary[index]);
        });
  }

  Widget _buildItem(BuildContext context, String culinary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Container(
              color: lightColorScheme.primaryContainer,
              child: Image.asset(
                'assets/makanan.jpg',
                fit: BoxFit.cover,
                width: 54,
                height: 54,
              ),
            )),
        const SizedBox(
          height: 8,
        ),
        Text(culinary)
      ],
    );
  }
}
