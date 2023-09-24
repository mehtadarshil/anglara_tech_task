import 'package:anglara_tech_task/features/blocs/cart_bloc/cart_bloc.dart';
import 'package:anglara_tech_task/features/blocs/categories_bloc/categories_bloc.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/route_constants.dart';
import 'package:anglara_tech_task/shared/utils/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab(
      {super.key, required this.categoriesBloc, required this.cartBloc});

  final CategoriesBloc categoriesBloc;
  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          CarouselSlider(
            options: CarouselOptions(
                height: 200.0, autoPlay: true, enableInfiniteScroll: false),
            items: [1, 2, 3].map((i) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "https://picsum.photos/200/300",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 30,
          ),
          BlocProvider(
            create: (context) => categoriesBloc,
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              bloc: categoriesBloc,
              builder: (context, state) {
                return state is CategoriesListState
                    ? Wrap(
                        spacing: 20,
                        runSpacing: 15,
                        children: state.categories
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                            RouteList.categoryProductsList,
                                            arguments: e.toString())
                                        .then((value) {
                                      Logger.prints("Cart updated");
                                      cartBloc
                                          .add(CartUpdate(key: UniqueKey()));
                                    });
                                  },
                                  child: Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primaryColor),
                                        color: AppColors.primaryLightColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      e.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily:
                                              FontFamily.poppinsSemiBold,
                                          fontSize: 14),
                                    ),
                                  ),
                                ))
                            .toList(),
                      )
                    : const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}
