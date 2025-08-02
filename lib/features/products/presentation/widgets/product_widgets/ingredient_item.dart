import 'package:flutter/material.dart';
import 'package:my_kitchen/features/products/domain/product_model.dart';

class IngredientItem extends StatelessWidget {
  const IngredientItem({
    required this.product,
    required this.onTap,
    required this.onLongPress,
    required this.isSelected,
    super.key,
  });

  final bool isSelected;
  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected
                ? Colors.lightGreen.shade100
                : getFreshnessColor(product.expirationDate),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            spacing: 12,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(Icons.apple, size: 24, color: Colors.green),
              Text(product.name),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getFreshnessColor(String expirationDateString) {
    final expirationDate = DateTime.tryParse(expirationDateString);
    if (expirationDate == null) return Colors.grey.withValues(alpha: 0.15);

    final now = DateTime.now();
    final difference = expirationDate.difference(now).inDays;

    if (difference < 0) return Colors.red.withValues(alpha: 0.15);
    if (difference <= 1) return Colors.orange.withValues(alpha: 0.15);
    return Colors.green.withValues(alpha: 0.15);
  }
}
