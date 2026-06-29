import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sofra/core/services/service_locator.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_card.dart';
import 'package:sofra/core/widgets/custom_tag_row.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/home/domain/usecases/get_top_liked_recipe_usecase.dart';
import 'package:sofra/features/recipe%20details/recipe_details.dart';

class PopularItemCard extends StatefulWidget {
  const PopularItemCard({super.key});

  @override
  State<PopularItemCard> createState() => _PopularItemCardState();
}

class _PopularItemCardState extends State<PopularItemCard> {
  RecipeEntity? _recipe;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchTopLikedRecipe();
  }

  Future<void> _fetchTopLikedRecipe() async {
    try {
      final getTopLikedRecipeUseCase = sl<GetTopLikedRecipeUseCase>();
      final recipe = await getTopLikedRecipeUseCase();
      if (mounted) {
        setState(() {
          _recipe = recipe;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildRecipeImage(RecipeEntity recipe) {
    final imagePath = recipe.imageUrl;
    if (imagePath.isEmpty) {
      return Image.asset(
        'assets/images/ErrorImg.png',
        height: 140,
        fit: BoxFit.contain,
      );
    }

    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        height: 140,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/ErrorImg.png',
          height: 140,
          fit: BoxFit.contain,
        ),
      );
    }

    return Image.asset(
      imagePath,
      height: 140,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        'assets/images/ErrorImg.png',
        height: 140,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CustomCard(
        height: 240,
        bgColor: AppColors.secondaryColor[200]!,
        containerBody: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor[500],
          ),
        ),
      );
    }

    final recipe = _recipe;
    if (recipe == null) {
      return CustomCard(
        height: 240,
        bgColor: AppColors.secondaryColor[200]!,
        containerBody: Center(
          child: Text(
            _errorMessage ?? "No popular items found",
            style: AppFonts.bodyMedium.copyWith(color: AppColors.errorColor),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetails(recipeId: recipe.id),
          ),
        );
      },
      child: CustomCard(
        height: 240,
        bgColor: AppColors.secondaryColor[200]!,
        containerBody: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTagRow(
                        label: "Featured",
                        color: AppColors.tertiaryColor[200],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipe.title,
                        style: AppFonts.header.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0088FF),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.neutralColor, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.neutralColor,
                        offset: Offset(4, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.thumbsUpIcon,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        recipe.likeCount.toString(),
                        style: TextStyle(
                          color: AppColors.tertiaryColor[50],
                          fontFamily: AppFonts.robotoCondensed,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              recipe.description,
                              style: AppFonts.bodyMedium.copyWith(
                                color: AppColors.seconderyFontColor,
                                fontSize: 15,
                                height: 1.3,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor[500],
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.neutralColor,
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.neutralColor,
                                offset: Offset(4, 4),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            "Grab it",
                            style: TextStyle(
                              color: AppColors.secondaryColor[500],
                              fontFamily: AppFonts.hankenGrotesk,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildRecipeImage(recipe),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
