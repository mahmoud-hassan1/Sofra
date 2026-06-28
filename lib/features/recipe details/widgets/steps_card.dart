import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_card.dart';
import '../domain/entities/recipe_details_entity.dart';

class StepsCard extends StatelessWidget {
  final List<RecipeStepEntity> steps;

  const StepsCard({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 100.0 + (steps.length * 130.0),
      width: 354,
      bgColor: AppColors.backGroundSecondColor,
      containerBody: Column(
        children: [
          Row(
            children: [
              Icon(Icons.note_alt_outlined),
              Text(" Steps", style: AppFonts.header),
            ],
          ),
          Divider(color: Colors.black, thickness: 1.5),
          SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => stepsBuilder(step: steps[index]),
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: steps.length,
          ),
        ],
      ),
    );
  }

  CustomCard stepsBuilder({required RecipeStepEntity step}) {
    return CustomCard(
      shadow: 3,
      height: 104,
      width: 316,
      bgColor: AppColors.backGroundColor,
      containerBody: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.brownAppBarBackground,
            radius: 20,
            child: Center(
              child: Text(
                step.order.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(child: Text(step.text)),
        ],
      ),
    );
  }
}
