import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/di/cart_manager_di.dart';
import 'package:anglara_tech_task/features/blocs/quntity_bloc/quntity_bloc.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/utils/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartButtom extends StatelessWidget {
  const AddToCartButtom(
      {super.key, required this.e, required this.quntityBloc});

  final ProductModel e;
  final QuntityBloc quntityBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => quntityBloc,
      child: BlocBuilder<QuntityBloc, QuntityState>(
        bloc: quntityBloc,
        builder: (context, state) {
          return state.qty == 0
              ? GestureDetector(
                  onTap: () async {
                    await CartManager.addProduct(productModel: e).then((value) {
                      quntityBloc.add(QuntityUpdate());
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryColor),
                    child: const Text(
                      Strings.strAddtoCart,
                      style: TextStyle(
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColors.whiteColor,
                          fontSize: 12),
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryLightColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          CartManager.increaseQuntity(
                                  id: e.id.toString(), count: state.qty)
                              .then(
                                  (value) => quntityBloc.add(QuntityUpdate()));
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primaryColor),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      Text(
                        state.qty.toString(),
                        style: const TextStyle(
                            fontFamily: FontFamily.poppinsMedium),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (state.qty == 1) {
                            CartManager.removeProduct(productModel: e).then(
                                (value) => quntityBloc.add(QuntityUpdate()));
                          } else {
                            CartManager.decreseQuntity(
                                    id: e.id.toString(), count: state.qty)
                                .then((value) =>
                                    quntityBloc.add(QuntityUpdate()));
                          }
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primaryColor),
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 5),
                );
        },
      ),
    );
  }
}
