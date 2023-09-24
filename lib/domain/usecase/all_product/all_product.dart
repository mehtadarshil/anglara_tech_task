import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/domain/entities/app_error.dart';
import 'package:anglara_tech_task/domain/repositories/all_product_list_repository.dart';
import 'package:anglara_tech_task/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class AllProductUseCase extends UseCase<List<ProductModel>, dynamic> {
  final AllProductListRepository _allProductListRepository;

  AllProductUseCase(this._allProductListRepository);

  @override
  Future<Either<AppError, List<ProductModel>>> call(params) async =>
      _allProductListRepository.getAllProducts();
}
