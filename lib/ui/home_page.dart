import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/provider/login_provider.dart';
import 'package:restaurant_app/data/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
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
                child: Consumer<LoginProvider>(builder: (context, login, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      login.currentUser!.photoURL!,
                      height: 36,
                      width: 36,
                    ),
                  );
                }))
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/cooking-food.jpg'),
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
      builder: (context, provider, _) {
        if (provider.state == ResultState.loading) {
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
        } else if (provider.state == ResultState.hasData) {
          final data = provider.restaurantResult.restaurants;
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
        } else if (provider.state == ResultState.noData) {
          return SizedBox(
              height: 120, child: Center(child: Text(provider.message)));
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(provider.message),
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
      onTap: () => Navigation.intentWithData(
          RestaurantDetailPage.routeName, restaurant.id),
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
                'assets/${culinary.toLowerCase()}.jpg',
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
