import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/blocs/category/category_bloc.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/category_item.dart';
import 'package:simple_pos/ui/widgets/menu_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      children: [
        buildHeader(),
        buildCategory(context),
        buildMenuData(context),
      ],
    );
  }

  Widget buildHeader() {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Howdy,",
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "Arif Hidayat",
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage("assets/store.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocProvider(
            create: (context) => CategoryBloc()..add(CategoryGet()),
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryPostSuccess) {
                  context.read<CategoryBloc>().add(CategoryGet());
                }
              },
              builder: (context, state) {
                return BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategorySuccess) {
                      return Wrap(
                        spacing: 14,
                        runSpacing: 10,
                        children: state.categories.map((category) {
                          return CategoryItem(
                            category: category,
                          );
                        }).toList(),
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/category',
              );
            },
            child: Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              width: double.infinity,
              child: Text(
                "See all category",
                style: blueTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuData(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menu Data',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 14,
            runSpacing: 10,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/category_form',
                  );
                },
                child: const MenuItem(
                  name: "Category",
                  imageUrl: "assets/ic_more.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/order_method',
                  );
                },
                child: const MenuItem(
                  name: "Order",
                  imageUrl: "assets/ic_help.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/payment_method',
                  );
                },
                child: const MenuItem(
                  name: "Payment",
                  imageUrl: "assets/ic_wallet_setting.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/item_form',
                  );
                },
                child: const MenuItem(
                  name: "Item",
                  imageUrl: "assets/ic_history.png",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
