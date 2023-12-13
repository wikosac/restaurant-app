import 'package:flutter/material.dart';
import 'package:restaurant_app/model/Restaurant.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final data = dataFromJson(snapshot.data!);
        final restaurant = data.restaurants;
        return ListView.builder(
          itemCount: restaurant.length,
          itemBuilder: (context, index) {
            return _buildRestaurantItem(context, restaurant[index]);
          },
        );
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            restaurant.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city),
        onTap: () {
          // Navigator.pushNamed(context, ArticleDetailPage.routeName, arguments: restaurant);
        },
      ),
    );
  }
}
