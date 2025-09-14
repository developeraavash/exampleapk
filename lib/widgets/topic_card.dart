import 'package:exampleapk/core/colors.dart';
import 'package:exampleapk/faculty_selection_screen.dart';
import 'package:flutter/material.dart';

// --------- TopicCard widget (your style) ---------
class TopicCard extends StatelessWidget {
  final String title;
  final String questionCount;
  final Color facultyColor;
  final IconData icon;

  const TopicCard({
    Key? key,
    required this.title,
    required this.questionCount,
    required this.facultyColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CColors.containerBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: facultyColor.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: facultyColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CColors.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  questionCount,
                  style: const TextStyle(
                    fontSize: 12,
                    color: CColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
