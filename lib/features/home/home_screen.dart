import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/home/widget/filter_row.dart';
import 'package:sofra/features/home/widget/home_card.dart';
import 'package:sofra/features/home/widget/popular_item_card.dart';
import 'package:sofra/features/home/widget/search_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> dummyData = [
    {
      'title': 'Cheese Burger',
      'bgColor': AppColors.secondaryColor[200]!,
      'category': 'Fast Food',
      'deliveryTime': '10m',
      'tags': ['italian', 'dinner'],
    },
    {
      'title': 'Spicy Tacos',
      'bgColor': AppColors.pinkAccentColor,
      'category': 'Mexican',
      'deliveryTime': '15m',
      'tags': ['mexican', 'lunch'],
    },
    {
      'title': 'Pasta Bolognese',
      'bgColor': AppColors.secondaryColor[200]!,
      'category': 'Italian',
      'deliveryTime': '25m',
      'tags': ['italian', 'dinner'],
    },
    {
      'title': 'Sushi Platter',
      'bgColor': AppColors.pinkAccentColor,
      'category': 'Japanese',
      'deliveryTime': '30m',
      'tags': ['sushi', 'dinner'],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tertiaryColor[500],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchInput(),
                    const SizedBox(height: 32),
                    PopularItemCard(),
                    const SizedBox(height: 32),
                    FilterRow(),
                    const SizedBox(height: 32),
                    Text("Nearby Craves", style: AppFonts.header),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              SliverList.builder(
                itemCount: dummyData.length,
                itemBuilder: (context, index) {
                  final item = dummyData[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: HomeCard(
                      bgColor: item['bgColor'],
                      title: item['title'],
                      category: item['category'],
                      deliveryTime: item['deliveryTime'],
                      tags: item['tags'],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
