part of 'recipes_bloc.dart';

class RecipesState extends Equatable {
  const RecipesState({required this.recipes, this.isLoading, this.error});

  final List<RecipeModel> recipes;
  final bool? isLoading;
  final String? error;

  RecipesState copyWith({
    List<RecipeModel>? recipes,
    bool? isLoading,
    String? error,
  }) {
    return RecipesState(
      recipes: recipes ?? this.recipes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [recipes, isLoading, error];
}
