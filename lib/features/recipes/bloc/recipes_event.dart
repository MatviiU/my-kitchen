part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFilteredRecipesEvent extends RecipesEvent {
  const LoadFilteredRecipesEvent(this.selectedIngredients);

  final List<String> selectedIngredients;

  @override
  List<Object?> get props => [selectedIngredients];
}
