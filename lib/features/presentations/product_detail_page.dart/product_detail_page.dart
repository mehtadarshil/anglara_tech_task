import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/features/blocs/quntity_bloc/quntity_bloc.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/utils/extension/widget_extensions.dart';
import 'package:anglara_tech_task/shared/widgets/add_to_cart_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductModel;
    final QuntityBloc quntityBloc = QuntityBloc(product.id.toString());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: const Text(
          Strings.strProductDetail,
          style: TextStyle(
              fontFamily: FontFamily.poppinsBold, color: AppColors.blackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: product.image!,
                width: size.width * 0.9,
                height: size.width * 0.9,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              product.title ?? "",
              style: const TextStyle(
                  fontFamily: FontFamily.poppinsSemiBold, fontSize: 17),
            ).paddingSymmetric(horizontal: 10),
            const SizedBox(
              height: 15,
            ),
            const Text(
              Strings.strDescription,
              style: TextStyle(
                  fontFamily: FontFamily.poppinsSemiBold, fontSize: 15),
            ).paddingSymmetric(horizontal: 10),
            Text(
              product.description ?? "",
              style: const TextStyle(
                  fontFamily: FontFamily.poppinsRegular, fontSize: 13),
            ).paddingSymmetric(horizontal: 10),
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: Strings.strCategory,
                  style: TextStyle(
                      fontFamily: FontFamily.poppinsSemiBold, fontSize: 15)),
              TextSpan(
                  text: product.category,
                  style: const TextStyle(
                      fontFamily: FontFamily.poppinsRegular, fontSize: 15))
            ])).paddingSymmetric(horizontal: 10),
            const SizedBox(
              height: 40,
            ),
            RatingStars(
              value: product.rating!.rate!,
            ),
            Text(
              Strings.strRatingCount + product.rating!.count.toString(),
              style: const TextStyle(
                  fontFamily: FontFamily.poppinsRegular, fontSize: 13),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, -2),
                  color: AppColors.blackColor.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10)
            ]),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "₹ ${product.price}",
                style: const TextStyle(
                    fontFamily: FontFamily.poppinsSemiBold, fontSize: 17),
              ),
            ),
            SizedBox(
              width: size.width * 0.4,
              child: AddToCartButtom(e: product, quntityBloc: quntityBloc),
            )
          ],
        ).paddingSymmetric(horizontal: 15),
      ),
    );
  }
}
