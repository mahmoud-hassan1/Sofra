import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/widgets/custom_tag_row.dart';
import 'package:sofra/features/home/cubit/home_body_cubit.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key});

  static const List<String> _tags = [
    "All",
    "Mexican",
    "Spanish",
    "Egyptian",
    "African",
    "French",
    "Thai",
    "Italian",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBodyCubit, HomeBodyState>(
      builder: (context, state) {
        final selectedIndex = _tags.indexOf(state.selectedRegion);
        final activeIndex = selectedIndex == -1 ? 0 : selectedIndex;

        return SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 14,
            runSpacing: 16.0,
            children: List.generate(
              _tags.length,
              (index) => CustomTagRow(
                label: _tags[index],
                isActive: activeIndex == index,
                onTap: () {
                  context.read<HomeBodyCubit>().changeRegion(_tags[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}