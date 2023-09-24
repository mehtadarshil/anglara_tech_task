import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/features/blocs/quntity_bloc/quntity_bloc.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/route_constants.dart';
import 'package:anglara_tech_task/shared/utils/extension/widget_extensions.dart';
import 'package:anglara_tech_task/shared/widgets/add_to_cart_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.e});

  final ProductModel e;

  @override
  Widget build(BuildContext context) {
    final QuntityBloc quntityBloc = QuntityBloc(e.id.toString());
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteList.productDetail, arguments: e)
            .then((value) {
          quntityBloc.add(QuntityUpdate());
        });
      },
      child: SizedBox(
        height: 280,
        width: size.width * 0.45,
        child: Card(
          elevation: 5,
          color: AppColors.whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              CachedNetworkImage(
                      height: 140,
                      width: size.width * 0.35,
                      fit: BoxFit.fill,
                      imageUrl: e.image!)
                  .paddingTop(10),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  e.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: FontFamily.poppinsMedium, fontSize: 14),
                ).paddingSymmetric(horizontal: 10),
              ),
              Row(
                children: [
                  Text(
                    "₹ ${e.price}",
                    style: const TextStyle(
                        fontFamily: FontFamily.poppinsRegular, fontSize: 13),
                  ).paddingSymmetric(horizontal: 10, vertical: 5),
                ],
              ),
              AddToCartButtom(
                e: e,
                quntityBloc: quntityBloc,
              ).paddingSymmetric(horizontal: 5).paddingBottom(5)
            ],
          ),
        ),
      ),
    );
  }
}
