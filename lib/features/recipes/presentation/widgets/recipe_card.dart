import 'package:flutter/material.dart';
import 'package:my_kitchen/features/recipes/domain/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({required this.recipe, required this.onTap, super.key});

  final RecipeModel recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  recipe.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
