import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/list_item.dart';
import 'package:restaurant_app/widget/shimmer.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/restaurant_favorite';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Favorit',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
        ),
        body: _buildList(context)
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.loading) {
          return SizedBox(
            height: 1000,
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const MyShimmer();
                }),
          );
        } else if (provider.state == ResultState.hasData) {
          final data = provider.favorites;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListItem(restaurant: data[index]);
            },
          );
        } else if (provider.state == ResultState.noData) {
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 180,
              child: Center(child: Text(provider.message)));
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
