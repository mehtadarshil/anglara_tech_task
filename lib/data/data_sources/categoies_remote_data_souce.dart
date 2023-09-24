import 'package:anglara_tech_task/data/core/api_client.dart';
import 'package:anglara_tech_task/data/core/api_constants.dart';
import 'package:anglara_tech_task/data/models/product_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List> getAllCategories();
  Future<List<ProductModel>> getCategoryProducts({required String category});
}

class CategoriesRemoteDataSourceImpl extends CategoriesRemoteDataSource {
  final ApiClient _apiClient;

  CategoriesRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List> getAllCategories() async {
    var categories = await _apiClient.get(ApiConstants.wsCategories);
    return categories;
  }

  @override
  Future<List<ProductModel>> getCategoryProducts(
      {required String category}) async {
    var products = await _apiClient
        .get(ApiConstants.wsCategoriesSpecific + category, jsonDecoded: false);
    return productModelFromJson(products);
  }
}
