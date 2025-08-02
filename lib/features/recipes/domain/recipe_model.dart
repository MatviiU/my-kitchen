class RecipeModel {
  const RecipeModel({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.ingredients,
    required this.steps,
    required this.tags,
    this.id,
  });

  factory RecipeModel.fromDb(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String,
      imagePath: map['imagePath'] as String,
      ingredients: (map['ingredients'] as String).split(','),
      steps: (map['steps'] as String).split('|'),
      tags: (map['tags'] as String).split(','),
    );
  }

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      steps: List<String>.from(json['steps'] as List),
      tags: List<String>.from(json['tags'] as List),
    );
  }

  final int? id;
  final String name;
  final String description;
  final String imagePath;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> tags;

  Map<String, dynamic> toDb() => {
    'id': id,
    'name': name,
    'description': description,
    'imagePath': imagePath,
    'ingredients': ingredients.join(','),
    'steps': steps.join('|'),
    'tags': tags.join(','),
  };
}
