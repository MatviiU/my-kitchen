import 'package:my_kitchen/core/database/app_database_service.dart';
import 'package:my_kitchen/features/recipes/data/recipes_repository.dart';
import 'package:my_kitchen/features/recipes/domain/recipe_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteRecipesRepository implements RecipesRepository {
  static const _tableName = 'recipes';

  @override
  Future<List<RecipeModel>> getAllRecipes() async {
    final db = await AppDatabaseService.database;
    final maps = await db.query(_tableName);
    return maps.map(RecipeModel.fromDb).toList();
  }

  @override
  Future<List<RecipeModel>> getRecipesFilteredByIngredients(
    List<String> availableIngredients,
  ) async {
    final recipes = await getAllRecipes();
    final normalizedIngredients = availableIngredients
        .map((ingredient) => ingredient.toLowerCase())
        .toList();

    return recipes.where((recipe) {
      return recipe.ingredients.any(
        (ingredient) =>
            normalizedIngredients.contains(ingredient.toLowerCase()),
      );
    }).toList();
  }

  @override
  Future<void> insertRecipe(RecipeModel recipe) async {
    final db = await AppDatabaseService.database;
    await db.insert(
      _tableName,
      recipe.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
