import 'package:flutter/material.dart';
import 'package:restaurant_app/model/Restaurant.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: widget.restaurant.pictureId,
                child: Image.network(widget.restaurant.pictureId)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restaurant.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Lokasi: ${widget.restaurant.city}'),
                  Text('Rating: ${widget.restaurant.rating.toString()}'),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.restaurant.description,
                    style: const TextStyle(fontSize: 16),
                    maxLines: isExpanded ? 30 : 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'Lebih sedikit' : 'Selengkapnya...',
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('Makanan'),
                  _buildList(context, widget.restaurant.menus.foods, 'assets/food.png'),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('Minuman'),
                  _buildList(context, widget.restaurant.menus.drinks, 'assets/drink.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Menu> menus, String asset) {
    return SizedBox(
      height: 120,
      child: Expanded(
        child: ListView.builder(
          itemExtent: 180,
          scrollDirection: Axis.horizontal,
          itemCount: menus.length,
          itemBuilder: (context, index) {
            return _buildMenuItem(context, menus[index], asset);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Menu menu, String asset) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          transformAlignment: Alignment.center,
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              Image.asset(asset),
              const SizedBox(height: 4,),
              Expanded(
                child: Text(
                  menu.name,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
