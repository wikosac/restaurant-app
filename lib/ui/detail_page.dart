import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/detail_result.dart' as dr;
import 'package:restaurant_app/data/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/shimmer.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  const RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Consumer<RestaurantProvider>(builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            SizedBox(
              height: 120,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const MyShimmer();
                  }),
            );
          } else if (state.state == ResultState.hasData) {
            final data = state.detailResult.restaurant;
            return Column(
              children: [
                Hero(
                    tag: data.id,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(16)),
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/small/${data.pictureId}",
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // Show a placeholder image from a local asset when loading fails
                            return Image.asset(
                              'assets/restaurant.png',
                              fit: BoxFit.cover,
                              height: 180,
                            );
                          },
                        ))),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Lokasi: ${data.city}'),
                      Row(
                        children: [
                          const Text('Rating: '),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(data.rating.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.description,
                        style: const TextStyle(fontSize: 16),
                        maxLines: isExpanded ? 30 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Text(
                          isExpanded ? 'Lebih sedikit' : 'Selengkapnya',
                          style:
                          const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Makanan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildList(context, data.menus.foods, 'assets/food.png'),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Minuman',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildList(context, data.menus.drinks, 'assets/drink.png'),
                    ],
                  ),
                ),
              ],
            );
          } else if (state.state == ResultState.noData) {
            return const SizedBox(
                height: 120, child: Center(child: Text('Tidak ada data')));
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          }
          return SizedBox(
            height: 120,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const MyShimmer();
                }),
          );
        }),
      ),
    );
  }

  Widget _buildList(
      BuildContext context, List<dr.Category>? menus, String asset) {
    return SizedBox(
      height: 136,
      child: ListView.builder(
        itemExtent: 180,
        scrollDirection: Axis.horizontal,
        itemCount: menus?.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(context, menus?[index], asset);
        },
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, dr.Category? category, String asset) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 4,
                blurRadius: 2,
                offset: Offset(2, 5),
              ),
            ],
          ),
          alignment: Alignment.center,
          transformAlignment: Alignment.center,
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(asset)),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  category?.name ?? '',
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Rp10.0000',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
