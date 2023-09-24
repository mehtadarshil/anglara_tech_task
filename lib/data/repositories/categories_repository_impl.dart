import 'dart:io';

import 'package:anglara_tech_task/data/core/unathorised_exception.dart';
import 'package:anglara_tech_task/data/data_sources/categoies_remote_data_souce.dart';
import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/domain/entities/app_error.dart';
import 'package:anglara_tech_task/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  final CategoriesRemoteDataSource _categoriesRemoteDataSource;

  CategoriesRepositoryImpl(this._categoriesRemoteDataSource);

  @override
  Future<Either<AppError, List>> getAllCategories() async {
    try {
      final categoriesData =
          await _categoriesRemoteDataSource.getAllCategories();

      return Right(categoriesData);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<ProductModel>>> getCategoryProducts(
      {required String category}) async {
    try {
      final products = await _categoriesRemoteDataSource.getCategoryProducts(
          category: category);

      return Right(products);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
