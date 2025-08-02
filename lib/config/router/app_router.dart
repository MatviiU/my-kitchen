import 'package:go_router/go_router.dart';
import 'package:my_kitchen/config/router/screen_names.dart';

import 'package:my_kitchen/features/products/presentation/views/add_product_screen.dart';
import 'package:my_kitchen/features/products/presentation/views/products_screen.dart';
import 'package:my_kitchen/features/recipes/presentation/views/recipe_screen.dart';
import 'package:my_kitchen/features/scanner/presentation/views/scanner_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: ScreenNames.productScreen,
      builder: (context, state) => const ProductsScreen(),
      routes: [
        GoRoute(
          path: 'add-product',
          name: ScreenNames.addProductScreen,
          builder: (context, state) => const AddProductScreen(),
        ),
        GoRoute(
          path: 'scanner',
          name: ScreenNames.scannerScreen,
          builder: (context, state) => const ScannerScreen(),
        ),
        GoRoute(
          path: 'recipes',
          name: ScreenNames.recipesScreen,
          builder: (context, state) {
            final selectedIngredients = state.extra as List<String>?;
            return RecipeScreen(selectedIngredients: selectedIngredients ?? []);
          },
        ),
      ],
    ),
  ],
);
