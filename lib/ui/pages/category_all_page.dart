import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/blocs/category/category_bloc.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/category_item.dart';

class CategoryAllPage extends StatelessWidget {
  const CategoryAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => CategoryBloc()..add(CategoryGetAll()),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CategorySuccess) {
              if (state.categories.isEmpty) {
                return Center(
                  child: Text(
                    "Category Empty",
                    style: greyTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: medium,
                    ),
                  ),
                );
              } else {
                return ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Wrap(
                      spacing: 14,
                      runSpacing: 10,
                      children: state.categories.map(
                        (category) {
                          return CategoryItem(category: category);
                        },
                      ).toList(),
                    ),
                  ],
                );
              }
            }

            return Container();
          },
        ),
      ),
    );
  }
}
