import 'package:anglara_tech_task/domain/entities/app_error.dart';
import 'package:anglara_tech_task/domain/repositories/categories_repository.dart';
import 'package:anglara_tech_task/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class CategoriesListUseCase extends UseCase<List, dynamic> {
  final CategoriesRepository _categoriesRepository;

  CategoriesListUseCase(this._categoriesRepository);

  @override
  Future<Either<AppError, List>> call(params) async =>
      _categoriesRepository.getAllCategories();
}
