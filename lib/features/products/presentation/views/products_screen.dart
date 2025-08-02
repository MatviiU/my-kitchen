import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kitchen/config/router/screen_names.dart';
import 'package:my_kitchen/features/products/bloc/product_bloc.dart';
import 'package:my_kitchen/features/products/presentation/widgets/product_widgets/ingredient_action_buttons.dart';
import 'package:my_kitchen/features/products/presentation/widgets/product_widgets/ingredient_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(24),
          child: Text('Мої інгредієнти'),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) => current.products != previous.products,
        builder: (context, state) {
          if (state.isLoading ?? false) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text(state.error!));
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                if (state.products.isEmpty)
                  const Center(child: Text('Немає інгредієнтів')),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return IngredientItem(
                        product: product,
                        isSelected: state.selectedIds.contains(product.id),
                        onTap: () {},
                        onLongPress: () {},
                      );
                    },
                  ),
                ),
                IngredientActionButtons(
                  onAdd: () => context.goNamed(ScreenNames.addProductScreen),
                  onScan: () => context.goNamed(ScreenNames.scannerScreen),

                  toRecipes: () {
                    final products = state.products
                        .where(
                          (product) => state.selectedIds.contains(product.id),
                        )
                        .map((product) => product.name)
                        .toList();
                    context.goNamed(ScreenNames.recipesScreen, extra: products);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
