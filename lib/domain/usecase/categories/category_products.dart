import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/domain/entities/app_error.dart';
import 'package:anglara_tech_task/domain/repositories/categories_repository.dart';
import 'package:anglara_tech_task/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class CategoryProductsUseCase extends UseCase<List<ProductModel>, String> {
  final CategoriesRepository _categoriesRepository;

  CategoryProductsUseCase(this._categoriesRepository);

  @override
  Future<Either<AppError, List<ProductModel>>> call(String params) async =>
      _categoriesRepository.getCategoryProducts(category: params);
}
