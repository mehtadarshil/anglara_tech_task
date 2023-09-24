import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/di/cart_manager_di.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(CartState(
            products: CartManager.getCartItems(),
            count: CartManager.getCartItems().length)) {
    on<CartUpdate>((event, emit) {
      emit(CartState(
          products: CartManager.getCartItems(),
          count: CartManager.getCartItems().length));
    });
  }
}
