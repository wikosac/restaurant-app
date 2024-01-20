import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/list_item.dart';
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
            child:
                Consumer<RestaurantProvider>(builder: (context, provider, _) {
              return TextField(
                controller: controller,
                onChanged: (text) {
                  provider.searchRestaurant(query: text.toString());
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
                              provider.searchRestaurant(query: '');
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
      builder: (context, provider, _) {
        if (provider.state == ResultState.loading) {
          return SizedBox(
            height: 1000,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const MyShimmer();
              },
            ),
          );
        } else if (provider.state == ResultState.hasData) {
          final data = provider.restaurantList;
          if (provider.searchState == ResultState.loading) {
            return SizedBox(
              height: 1000,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const MyShimmer();
                },
              ),
            );
          } else if (provider.searchState == ResultState.noData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Center(child: Text(provider.message)),
                )
              ],
            );
          } else if (provider.searchState == ResultState.error) {
            return Center(
              child: Material(
                child: Text(provider.message),
              ),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListItem(restaurant: data[index]);
            },
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
        return Center(
          child: Material(
            child: Text(provider.message),
          ),
        );
      },
    );
  }
}
