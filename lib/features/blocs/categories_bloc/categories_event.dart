part of 'categories_bloc.dart';

class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class CategoriesList extends CategoriesEvent {}

class CategoryProductsList extends CategoriesEvent {
  final String category;

  const CategoryProductsList({required this.category});
  @override
  List<Object> get props => [category];
}
