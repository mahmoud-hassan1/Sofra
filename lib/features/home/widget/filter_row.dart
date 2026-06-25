import 'package:flutter/material.dart';
import 'package:sofra/core/widgets/custom_tag_row.dart';

class FilterRow extends StatefulWidget {
  const FilterRow({super.key});

  @override
  State<FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  int _selectedIndex = 0;

  final List<String> _tags = [
    "All",
    "Mexican",
    "Spanish",
    "Egyptian",
    "African",
    "French",
    "Thai",
    "Italian",
  ];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            isActive: _selectedIndex == index,
            onTap: () => onTap(index),
          ),
        ),
      ),
    );
  }
}