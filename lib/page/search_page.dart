import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/Restaurant.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage2 extends StatelessWidget {
  const SearchPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const TextField(
            decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none),
          ),
        ),
        body: _buildList(context),
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
                return _buildRestaurantItem(context, restaurant[index]);
              },
            );
          } else {
            return const Center(child: Text('Tidak ada data'));
          }
        }
        return ListView.builder(itemBuilder: (context, index) {
          return _shimmer(context);
        });
      },
    );
  }

  Widget _shimmer(BuildContext context) {
    // Show shimmer placeholder while loading
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        title: Container(
          width: 24,
          height: 16,
          color: Colors.white,
        ),
        subtitle: Container(
          width: 16,
          height: 12,
          color: Colors.white,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            color: Colors.white,
            width: 64,
            height: 64,
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        leading: Hero(
          tag: restaurant.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              color: lightColorScheme.tertiary,
              width: 64,
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    restaurant.pictureId,
                    fit: BoxFit.cover,
                    width: 64,
                    height: 36,
                  ),
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: const Text(
                      'data',
                      style: TextStyle(color: Colors.white),
                    ))
              ]),
            ),
          ),
        ),
        title: Text(
          restaurant.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Makanan & Minuman',
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
              ),
              Text(restaurant.city),
              Text(restaurant.rating.toString()),
        ]),
        onTap: () {
          // Navigator.pushNamed(context, ArticleDetailPage.routeName, arguments: restaurant);
        },
      ),
    );
  }
}
