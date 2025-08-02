import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kitchen/features/recipes/bloc/recipes_bloc.dart';
import 'package:my_kitchen/features/recipes/presentation/widgets/recipe_card.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({required this.selectedIngredients, super.key});

  final List<String> selectedIngredients;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RecipesBloc()..add(LoadFilteredRecipesEvent(selectedIngredients)),
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(24),
            child: Text('Рецепти для тебе'),
          ),
        ),
        body: BlocBuilder<RecipesBloc, RecipesState>(
          builder: (context, state) {
            if (state.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error == null) {
              return Center(child: Text(state.error!));
            }
            final recipes = state.recipes;
            if (recipes.isEmpty) {
              return const Center(child: Text('Немає відповідних рецептів'));
            }
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final recipe = recipes[index];
                return RecipeCard(recipe: recipe, onTap: () {});
              },
            );
          },
        ),
      ),
    );
  }
}
