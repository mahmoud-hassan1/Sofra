import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_card.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart' show IngredientEntity;

class IngredientsCard extends StatelessWidget {
  final List<IngredientEntity> ingredients;

  const IngredientsCard({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 100.0 + (ingredients.length * 48.0),
      width: 354,
      bgColor: AppColors.tertiaryColor,
      containerBody: Column(
        children: [
          Row(
            children: [
              Icon(Icons.shopping_cart_outlined),
              Text(" INGREDIENTS", style: AppFonts.header),
            ],
          ),
          Divider(color: Colors.black, thickness: 1.5),
          SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Row(
              children: [
                Expanded(child: Text(ingredients[index].name)),
                Text(ingredients[index].quantity),
              ],
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 24,
              child: Divider(color: Colors.grey),
            ),
            itemCount: ingredients.length,
          ),
        ],
      ),
    );
  }
}
