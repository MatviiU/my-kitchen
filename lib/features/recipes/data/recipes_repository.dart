import 'package:my_kitchen/features/recipes/domain/recipe_model.dart';

abstract class RecipesRepository {
  Future<void> insertRecipe(RecipeModel recipe);

  Future<List<RecipeModel>> getAllRecipes();

  Future<List<RecipeModel>> getRecipesFilteredByIngredients(
    List<String> availableIngredients,
  );
}
