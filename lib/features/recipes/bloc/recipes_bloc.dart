import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kitchen/features/recipes/data/sqlite_recipes_repository.dart';
import 'package:my_kitchen/features/recipes/domain/recipe_model.dart';

part 'recipes_event.dart';

part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc() : super(const RecipesState(recipes: [])) {
    on<LoadFilteredRecipesEvent>(_loadFilteredRecipes);
  }

  final _recipesRepository = SqliteRecipesRepository();

  Future<void> _loadFilteredRecipes(
    LoadFilteredRecipesEvent event,
    Emitter<RecipesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final recipes = await _recipesRepository.getRecipesFilteredByIngredients(
        event.selectedIngredients,
      );
      emit(state.copyWith(recipes: recipes, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
