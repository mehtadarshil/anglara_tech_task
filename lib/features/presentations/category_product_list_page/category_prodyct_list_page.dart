import 'package:anglara_tech_task/features/blocs/categories_bloc/categories_bloc.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsListPage extends StatefulWidget {
  const CategoryProductsListPage({super.key});

  @override
  State<CategoryProductsListPage> createState() =>
      _CategoryProductsListPageState();
}

class _CategoryProductsListPageState extends State<CategoryProductsListPage> {
  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      _categoriesBloc.add(CategoryProductsList(category: args));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _categoriesBloc,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          foregroundColor: AppColors.blackColor,
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          title: const Text(
            Strings.strProducts,
            style: TextStyle(
                fontFamily: FontFamily.poppinsBold,
                color: AppColors.blackColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<CategoriesBloc, CategoriesState>(
                bloc: _categoriesBloc,
                builder: (context, state) {
                  return state is CategoryProductsListState
                      ? Center(
                          child: Wrap(
                            runAlignment: WrapAlignment.center,
                            children: state.products
                                .map((e) => ProductCard(e: e))
                                .toList(),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
