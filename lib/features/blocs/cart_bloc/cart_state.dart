part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    required this.products,
    required this.count,
  });

  final List<ProductModel> products;
  final int count;

  @override
  List<Object> get props => [products, count];
}
