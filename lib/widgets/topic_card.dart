import 'package:exampleapk/faculty.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final String title;
  final String questionCount;
  final Color facultyColor;
  final VoidCallback? onTap;

  const TopicCard({
    super.key,
    required this.title,
    required this.questionCount,
    required this.facultyColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CColors.containerBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: facultyColor.withValues(alpha:  0.1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: facultyColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: CColors.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  questionCount,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.play_circle_outline, color: facultyColor, size: 24),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }

    return content;
  }
}
