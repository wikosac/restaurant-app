import 'package:flutter/material.dart';
import 'package:restaurant_app/model/Restaurant.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar with a flexible space (banner image) and search bar
        const SliverAppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Cari',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none),
            ),
          ),
          pinned: true,
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/14',
              // Replace with your image URL
              fit: BoxFit.cover,
              height: 200.0,
            ),
          ),
        ),

        // SliverList with ListView
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return _buildList(context, index);
        }, childCount: 10))
      ],
    );
  }

  Widget _buildList(BuildContext context, int index) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final data = dataFromJson(snapshot.data!);
            final restaurant = data.restaurants;
            return _buildRestaurantItem(context, restaurant[index]);
          }
        }
        return const Center(child: Text('Tidak ada data'));
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

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
