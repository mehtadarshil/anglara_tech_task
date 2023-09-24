import 'package:anglara_tech_task/features/blocs/search_bloc/search_bloc.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/utils/extension/widget_extensions.dart';
import 'package:anglara_tech_task/shared/widgets/common_textfield.dart';
import 'package:anglara_tech_task/shared/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductPage extends StatelessWidget {
  const SearchProductPage({super.key});

  static final SearchBloc _searchBloc = SearchBloc()..add(SearchListGet());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc,
      child: Scaffold(
        body: Column(
          children: [
            CommonTextfield(
              controller: _searchBloc.searchController,
              hintText: Strings.strSearch,
              onChanged: (value) {
                _searchBloc.add(const SearchEvent());
              },
            ).paddingSymmetric(horizontal: 10, vertical: 15),
            Expanded(child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return state is SearchDataState
                    ? ListView.builder(
                        itemCount: state.searchResult.length,
                        itemBuilder: (context, index) =>
                            ProductCard(e: state.searchResult[index]),
                      )
                    : const SizedBox.shrink();
              },
            ))
          ],
        ),
      ),
    );
  }
}
