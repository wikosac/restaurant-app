import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/Restaurant.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/widget/shimmer.dart';

class SearchPage2 extends StatelessWidget {
  const SearchPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: TextField(
            onTap: () {
              // Display a Snackbar
              const snackBar = SnackBar(
                content: Text('Fitur ini segera hadir!'),
                duration: Duration(seconds: 3), // Adjust the duration as needed
              );

              // Find the Scaffold in the widget tree and show the Snackbar
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            decoration: InputDecoration(
                hintText: 'Cari restaurant..',
                hintStyle:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                )),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: _buildList(context),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final data = dataFromJson(snapshot.data!);
            final restaurant = data.restaurants;
            return ListView.builder(
              itemCount: restaurant.length,
              itemBuilder: (context, index) {
                return _buildListItem(context, restaurant[index]);
              },
            );
          } else {
            return const Center(child: Text('Tidak ada data'));
          }
        }
        return ListView.builder(itemBuilder: (context, index) {
          return const MyShimmer();
        });
      },
    );
  }

  Widget _buildListItem(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: 100,
                height: 100,
                color: lightColorScheme.tertiary,
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                        restaurant.pictureId,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 80,
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          // Show a placeholder image from a local asset when loading fails
                          return Image.asset(
                            'assets/icon.png', // Replace with the path to your local asset image
                            width: 100,
                            height: 80,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                          'Diskon 50%',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      )
                  )
                ]),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text(
                  'Makanan & Minuman',
                  style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  restaurant.city,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(restaurant.rating.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
