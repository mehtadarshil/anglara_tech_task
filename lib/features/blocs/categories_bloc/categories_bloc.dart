import 'package:anglara_tech_task/data/core/api_client.dart';
import 'package:anglara_tech_task/data/data_sources/categoies_remote_data_souce.dart';
import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/data/repositories/categories_repository_impl.dart';
import 'package:anglara_tech_task/domain/usecase/categories/categoires_list.dart';
import 'package:anglara_tech_task/domain/usecase/categories/category_products.dart';
import 'package:anglara_tech_task/shared/utils/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesList>((event, emit) async {
      var data = await CategoriesListUseCase(CategoriesRepositoryImpl(
              CategoriesRemoteDataSourceImpl(ApiClient(Client()))))
          .call('');
      data.fold((l) => Logger.prints(l), (r) {
        emit(CategoriesListState(categories: r));
      });
    });

    on<CategoryProductsList>((event, emit) async {
      var data = await CategoryProductsUseCase(CategoriesRepositoryImpl(
              CategoriesRemoteDataSourceImpl(ApiClient(Client()))))
          .call(event.category);
      data.fold((l) => Logger.prints(l), (r) {
        emit(CategoryProductsListState(products: r));
      });
    });
  }
}
