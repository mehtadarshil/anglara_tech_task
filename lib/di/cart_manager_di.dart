import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/di/app_component_base.dart';
import 'package:anglara_tech_task/shared/constants/storage_constants.dart';
import 'package:get_storage/get_storage.dart';

class CartManager {
  static List<ProductModel> getCartItems() {
    var rawData = GetStorage().read(StorageConstants.cartData);
    if (rawData == null) {
      return [];
    } else if (rawData is List<ProductModel>) {
      return rawData;
    } else {
      return (rawData as List).map((e) => ProductModel.fromJson(e)).toList();
    }
  }

  static Future increaseQuntity(
      {required String id, required int count}) async {
    AppComponentBase.instance.showProgressDialog();
    await GetStorage().write(id, count + 1);
    AppComponentBase.instance.hideProgressDialog();
  }

  static Future decreseQuntity({required String id, required int count}) async {
    AppComponentBase.instance.showProgressDialog();
    await GetStorage().write(id, count - 1);
    AppComponentBase.instance.hideProgressDialog();
  }

  static Future addProduct({required ProductModel productModel}) async {
    AppComponentBase.instance.showProgressDialog();
    var cartList = getCartItems();
    if (!cartList.any((element) => element.id == productModel.id)) {
      cartList.add(productModel);
      await GetStorage().write(StorageConstants.cartData, cartList);
      await GetStorage().write(productModel.id.toString(), 1);
    }
    AppComponentBase.instance.hideProgressDialog();
  }

  static Future removeProduct({required ProductModel productModel}) async {
    AppComponentBase.instance.showProgressDialog();
    var cartList = getCartItems();
    if (cartList.any((element) => element.id == productModel.id)) {
      cartList.removeWhere(
        (element) => element.id == productModel.id,
      );
      await GetStorage().write(StorageConstants.cartData, cartList);
      await GetStorage().write(productModel.id.toString(), 0);
    }
    AppComponentBase.instance.hideProgressDialog();
  }
}
