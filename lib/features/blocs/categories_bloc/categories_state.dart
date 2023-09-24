part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesListState extends CategoriesState {
  final List categories;

  const CategoriesListState({required this.categories});
  @override
  List<Object> get props => [categories];
}

class CategoryProductsListState extends CategoriesState {
  final List<ProductModel> products;

  const CategoryProductsListState({required this.products});

  @override
  List<Object> get props => [products];
}
