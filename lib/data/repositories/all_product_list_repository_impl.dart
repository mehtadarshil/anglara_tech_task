import 'dart:io';

import 'package:anglara_tech_task/data/core/unathorised_exception.dart';
import 'package:anglara_tech_task/data/data_sources/all_product_list_remote_data_source.dart';
import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/domain/entities/app_error.dart';
import 'package:anglara_tech_task/domain/repositories/all_product_list_repository.dart';
import 'package:dartz/dartz.dart';

class AllProductListRepositoryImpl extends AllProductListRepository {
  final AllProductListRemoteDataSource _allProductListRemoteDataSource;

  AllProductListRepositoryImpl(this._allProductListRemoteDataSource);
  @override
  Future<Either<AppError, List<ProductModel>>> getAllProducts() async {
    try {
      final data = await _allProductListRemoteDataSource.getAllProducts();

      return Right(data);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
