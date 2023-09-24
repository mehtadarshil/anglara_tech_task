part of 'cart_bloc.dart';

class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartUpdate extends CartEvent {
  final Key key;

  const CartUpdate({required this.key});
  @override
  List<Object?> get props => [key];
}
