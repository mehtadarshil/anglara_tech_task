import 'package:anglara_tech_task/data/core/api_client.dart';
import 'package:anglara_tech_task/data/core/api_constants.dart';
import 'package:anglara_tech_task/data/models/product_model.dart';

abstract class AllProductListRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
}

class AllProductListRemoteDataSourceImpl
    extends AllProductListRemoteDataSource {
  final ApiClient apiClient;

  AllProductListRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response =
        await apiClient.get(ApiConstants.wsAllProduct, jsonDecoded: false);
    return productModelFromJson(response);
  }
}
