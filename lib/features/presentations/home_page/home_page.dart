import 'package:anglara_tech_task/features/blocs/cart_bloc/cart_bloc.dart';
import 'package:anglara_tech_task/features/blocs/categories_bloc/categories_bloc.dart';
import 'package:anglara_tech_task/features/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:anglara_tech_task/features/presentations/home_page/tabs/cart_tab.dart';
import 'package:anglara_tech_task/features/presentations/home_page/tabs/home_tab.dart';
import 'package:anglara_tech_task/features/presentations/home_page/tabs/user_tab.dart';
import 'package:anglara_tech_task/features/presentations/home_page/widgets/home_drawer.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/route_constants.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/utils/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final GlobalKey<ScaffoldState> _key = GlobalKey();
  static final NavigationBloc _navigationBloc = NavigationBloc();
  static final CartBloc cartBloc = CartBloc();
  static final CategoriesBloc _categoriesBloc = CategoriesBloc()
    ..add(CategoriesList());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _navigationBloc,
        ),
        BlocProvider(
          create: (context) => _categoriesBloc,
        ),
        BlocProvider(
          create: (context) => cartBloc,
        ),
      ],
      child: Scaffold(
        key: _key,
        drawer: const HomeDrawer(),
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.whiteColor,
          leading: GestureDetector(
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: AppColors.blackColor,
            ),
          ),
          title: BlocBuilder<NavigationBloc, NavigationState>(
            bloc: _navigationBloc,
            builder: (context, state) {
              return Text(
                state.currentIndex == 0
                    ? Strings.strHome
                    : state.currentIndex == 1
                        ? Strings.strCart
                        : Strings.strUserProfile,
                style: const TextStyle(
                    fontFamily: FontFamily.poppinsBold,
                    color: AppColors.blackColor),
              );
            },
          ),
          actions: [
            BlocBuilder<NavigationBloc, NavigationState>(
              bloc: _navigationBloc,
              builder: (context, state) {
                return state.currentIndex == 0
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteList.searchProduct)
                              .then((value) {
                            cartBloc.add(CartUpdate(key: UniqueKey()));
                          });
                        },
                        child: const Icon(
                          Icons.search,
                          color: AppColors.blackColor,
                        ).paddingRight(15),
                      )
                    : const SizedBox.shrink();
              },
            )
          ],
        ),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          bloc: _navigationBloc,
          builder: (context, state) => [
            HomeTab(
              categoriesBloc: _categoriesBloc,
              cartBloc: cartBloc,
            ),
            CartTab(
              cartBloc: cartBloc,
            ),
            const UserTab()
          ][state.currentIndex],
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          bloc: _navigationBloc,
          builder: (context, state) {
            return Stack(
              children: [
                BottomNavigationBar(
                    currentIndex: state.currentIndex,
                    onTap: (value) {
                      _navigationBloc.add(NavigationChange(newIndex: value));
                    },
                    selectedItemColor: AppColors.primaryColor,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: Strings.strHome),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart_rounded),
                          label: Strings.strCart),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: Strings.strUserProfile)
                    ]),
                Positioned(
                    right: MediaQuery.of(context).size.width * 0.45,
                    top: 0,
                    child: BlocBuilder<CartBloc, CartState>(
                      bloc: cartBloc,
                      builder: (context, state) {
                        return state.products.isEmpty
                            ? const Offstage()
                            : Container(
                                height: 15,
                                width: 15,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.redColor),
                                child: Text(
                                  state.count > 9
                                      ? "9+"
                                      : state.count.toString(),
                                  style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 11),
                                ),
                              );
                      },
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
