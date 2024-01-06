import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widget/shimmer.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<RestaurantProvider>(builder: (context, provider, _) {
              return TextField(
                controller: controller,
                onChanged: (text) {
                  provider.searchRestaurantsByKeyword(text);
                },
                decoration: InputDecoration(
                    hintText: 'Cari restaurant..',
                    hintStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w300),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              controller.clear();
                              provider.searchRestaurantsByKeyword('');
                            },
                            child: const Icon(Icons.clear),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                    )),
                textInputAction: TextInputAction.search,
              );
            }),
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
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return SizedBox(
            height: 1000,
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const MyShimmer();
                }),
          );
        } else if (state.state == ResultState.hasData) {
          final data = (state.filteredRestaurants.isEmpty &&
          state.searchState != ResultState.noData)
              ? state.restaurantResult.restaurants
              : state.filteredRestaurants;
          if (state.searchState == ResultState.noData) {
            return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Center(child: Text(state.message)),
                  )
                ]
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return _buildListItem(context, data[index]);
            },
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
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant.id);
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
                        "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                        fit: BoxFit.cover,
                        width: 100,
                        height: 80,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          // Show a placeholder image from a local asset when loading fails
                          return Image.asset(
                            'assets/icon.png',
                            // Replace with the path to your local asset image
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
                      ))
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
