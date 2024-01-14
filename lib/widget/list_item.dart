import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/provider/database_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class ListItem extends StatelessWidget {
  final Restaurant restaurant;

  const ListItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return _buildListItem(context, restaurant);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                              return Image.asset(
                                'assets/icon.png',
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
            Consumer<DatabaseProvider>(
                builder: (context, provider, _) {
                  return FutureBuilder<bool>(
                      future: provider.isFavorited(restaurant.id),
                      builder: (context, snapshot) {
                        var isFavorite = snapshot.data ?? false;
                        return isFavorite
                            ? IconButton(
                              icon: const Icon(Icons.favorite),
                              color: Theme.of(context).colorScheme.error,
                              onPressed: () => provider.removeFavorite(restaurant.id),
                            )
                            : IconButton(
                              icon: const Icon(Icons.favorite_border),
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () => provider.addFavorite(restaurant),
                            );
                      }
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
