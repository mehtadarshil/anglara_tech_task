import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/di/cart_manager_di.dart';
import 'package:anglara_tech_task/features/blocs/cart_bloc/cart_bloc.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard(
      {super.key, required this.data, required this.cartBloc});

  final ProductModel data;
  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.primaryLightColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: data.image!,
            height: 50,
            width: 50,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: FontFamily.poppinsSemiBold),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        CartManager.removeProduct(productModel: data)
                            .then((value) {
                          cartBloc.add(CartUpdate(key: UniqueKey()));
                        });
                      },
                      child: const Text(
                        Strings.strRemove,
                        style: TextStyle(
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColors.primaryColor),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ ${data.price}",
                      style: const TextStyle(
                          fontFamily: FontFamily.poppinsRegular),
                    ),
                    Text(
                      Strings.strQty +
                          GetStorage().read(data.id.toString()).toString(),
                      style: const TextStyle(
                          fontFamily: FontFamily.poppinsRegular),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
