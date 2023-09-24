import 'package:anglara_tech_task/data/core/api_client.dart';
import 'package:anglara_tech_task/data/data_sources/all_product_list_remote_data_source.dart';
import 'package:anglara_tech_task/data/models/product_model.dart';
import 'package:anglara_tech_task/data/repositories/all_product_list_repository_impl.dart';
import 'package:anglara_tech_task/domain/usecase/all_product/all_product.dart';
import 'package:anglara_tech_task/shared/utils/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TextEditingController searchController = TextEditingController();
  List<ProductModel> allProducts = [];
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      if (searchController.text.isNotEmpty) {
        var searchData = allProducts
            .where((element) => element.title!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
        emit(SearchDataState(
            searchResult: searchData, searchQuery: searchController.text));
      } else {
        emit(SearchDataState(searchResult: allProducts, searchQuery: ""));
      }
    });

    on<SearchListGet>((event, emit) async {
      var data = await AllProductUseCase(AllProductListRepositoryImpl(
              AllProductListRemoteDataSourceImpl(
                  apiClient: ApiClient(Client()))))
          .call("");
      data.fold((l) => Logger.prints(l), (r) {
        allProducts = r;
        emit(SearchDataState(searchResult: allProducts, searchQuery: ""));
      });
    });
  }
}
