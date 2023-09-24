import 'package:anglara_tech_task/features/blocs/cart_bloc/cart_bloc.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/utils/extension/widget_extensions.dart';
import 'package:anglara_tech_task/shared/widgets/cart_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key, required this.cartBloc});

  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CartBloc, CartState>(
          bloc: cartBloc,
          builder: (context, state) {
            return Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  var data = state.products[index];
                  return CartProductCard(data: data, cartBloc: cartBloc);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            );
          },
        ),
        SizedBox(
          height: 60,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  Strings.strTotal,
                  style: TextStyle(
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColors.primaryColor,
                      fontSize: 17),
                ),
                BlocBuilder<CartBloc, CartState>(
                  bloc: cartBloc,
                  builder: (context, state) {
                    double total = 0;
                    for (var element in state.products) {
                      total += (element.price! *
                          GetStorage().read(element.id.toString()));
                    }
                    return Text(
                      total.toStringAsFixed(2),
                      style: const TextStyle(
                          fontFamily: FontFamily.poppinsSemiBold, fontSize: 17),
                    );
                  },
                )
              ],
            ).paddingSymmetric(horizontal: 10),
          ).paddingBottom(10),
        )
      ],
    );
  }
}
