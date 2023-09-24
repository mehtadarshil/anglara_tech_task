import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesRepository {
  Future<Either<AppError, List>> getAllCategories();
  Future<Either<AppError, List<ProductModel>>> getCategoryProducts(
      {required String category});
}
