import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ChapterChip extends StatelessWidget {
  final String title;
  final bool isActive;

  const ChapterChip({Key? key, required this.title, this.isActive = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
        backgroundColor: isActive
            ? CColors.primaryColor
            : Colors.grey.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
