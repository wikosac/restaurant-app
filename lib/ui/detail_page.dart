import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_result.dart' as dr;
import 'package:restaurant_app/data/model/detail_result.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/provider/database_provider.dart';
import 'package:restaurant_app/data/provider/detail_provider.dart';
import 'package:restaurant_app/data/provider/preferences_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/bottom_sheet.dart';
import 'package:restaurant_app/widget/shimmer_detail.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailProvider(apiService: ApiService(), id: id),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Consumer<DetailProvider>(builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const ShimmerDetailPage();
            } else if (state.state == ResultState.hasData) {
              return _buildColumn(context, state);
            } else if (state.state == ResultState.noData) {
              return SizedBox(
                  height: 120, child: Center(child: Text(state.message)));
            } else if (state.state == ResultState.error) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 180,
                child: Center(
                  child: Text(state.message),
                ),
              );
            }
            return const ShimmerDetailPage();
          }),
        ),
      ),
    );
  }

  Widget _buildColumn(BuildContext context, DetailProvider provider) {
    final data = provider.detailResult.restaurant;
    final rest = Restaurant.fromRestaurantDetail(data);
    return Column(
      children: [
        Hero(
            tag: data.pictureId,
            child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/large/${data.pictureId}",
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Image.asset(
                        'assets/restaurant.png',
                        fit: BoxFit.cover,
                        height: 180,
                      );
                    }
                  },
                ))),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Consumer<DatabaseProvider>(builder: (context, db, _) {
                    return FutureBuilder<bool>(
                        future: db.isFavorited(rest.id),
                        builder: (context, snapshot) {
                          var isFavorite = snapshot.data ?? false;
                          return isFavorite
                              ? IconButton(
                                  icon: const Icon(Icons.favorite),
                                  color: Theme.of(context).colorScheme.error,
                                  onPressed: () => db.removeFavorite(rest.id),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.favorite_border),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  onPressed: () => db.addFavorite(rest),
                                );
                        });
                  })
                ],
              ),
              Text(
                data.address,
                style: const TextStyle(fontSize: 12),
              ),
              Row(
                children: [
                  for (int i = 0; i < data.categories.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        data.categories[i].name,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(36.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: lightColorScheme.onInverseSurface,
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  data.rating.toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'Rating',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(36.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: lightColorScheme.onInverseSurface),
                            padding: const EdgeInsets.all(12.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                data.city,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'Lokasi',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                data.description,
                style: const TextStyle(fontSize: 16),
                maxLines: provider.isExpanded ? 30 : 2,
                overflow: TextOverflow.ellipsis,
              ),
              GestureDetector(
                onTap: () {
                  provider.setExpanded();
                },
                child: Text(
                  provider.isExpanded ? 'Lebih sedikit' : 'Selengkapnya',
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
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
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ulasan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Consumer2<DetailProvider, PreferencesProvider>(
                      builder: (context, detail, pref, _) {
                    final user = pref.credential;
                    final name = (user.isNotEmpty) ? user[1] : 'Anonim';
                    return IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        showBottomSheetDialog(context, (review) {
                          var msg = 'Ulasan tidak boleh kosong';
                          if (review.isNotEmpty) {
                            detail.postReview(
                                id: id, name: name, review: review);
                            msg = 'Berhasil menambah ulasan';
                          }
                          var snackBar = SnackBar(
                            content: Text(msg),
                            duration: const Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                    );
                  }),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Consumer<DetailProvider>(builder: (context, provider, _) {
                return _buildReview(
                    context, provider.detailResult.restaurant.customerReviews);
              })
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(
      BuildContext context, List<dr.Category> menus, String asset) {
    return SizedBox(
      height: 136,
      child: ListView.builder(
        itemExtent: 180,
        scrollDirection: Axis.horizontal,
        itemCount: menus.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(context, menus[index], asset);
        },
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, dr.Category category, String asset) {
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
                  category.name,
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

  Widget _buildReview(BuildContext context, List<CustomerReview> reviews) {
    return SizedBox(
      height: (100 * reviews.length).toDouble(),
      child: ListView.builder(
        itemExtent: 100,
        scrollDirection: Axis.vertical,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return _buildReviewItem(context, reviews[index]);
        },
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, dr.CustomerReview review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Consumer<PreferencesProvider>(builder: (context, pref, _) {
                    final user = pref.credential;
                    final name = (user.isNotEmpty) ? user[1] : 'Anonim';
                    return (review.name != name)
                        ? Container(
                            color: lightColorScheme.primaryContainer,
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.person,
                            ))
                        : Image.network(
                            user[2],
                            height: 36,
                            width: 36,
                          );
                  })),
            ),
            Text(
              review.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.review,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                review.date,
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        )
      ],
    );
  }
}
