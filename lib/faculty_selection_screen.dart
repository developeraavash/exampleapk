import 'package:exampleapk/core/colors.dart';
import 'package:exampleapk/widgets/faculty_card.dart';
import 'package:exampleapk/faculty_details_screen.dart';
import 'package:flutter/material.dart';

class FacultySelectionScreen extends StatelessWidget {
  const FacultySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.white,
      appBar: AppBar(
        // your existing app bar code...
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // your existing texts...
            const SizedBox(height: 20),
            const Text(
              'Select Your Faculty',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: CColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose your engineering stream',
              style: TextStyle(
                fontSize: 16,
                color: CColors.greyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),

            // Using the new FacultyCard widget
            FacultyCard(
              icon: Icons.computer,
              title: 'Computer Engineering',
              subtitle: '2,847 questions available',
              backgroundColor: CColors.primaryColor,
              onTap: () {
                Navigator.of(context).push(
                  _createRoute(
                    context,
                    'Computer Engineering',
                    CColors.primaryColor,
                    Icons.computer,
                    '2,847 questions available',
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            FacultyCard(
              icon: Icons.trending_up,
              title: 'Civil Engineering',
              subtitle: '1,923 questions available',
              backgroundColor: Color(0xFF4CAF50),
              onTap: () {
                Navigator.of(context).push(
                  _createRoute(
                    context,
                    'Civil Engineering',
                    Color(0xFF4CAF50),
                    Icons.trending_up,
                    '1,923 questions available',
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            FacultyCard(
              icon: Icons.settings,
              title: 'Mechanical Engineering',
              subtitle: '3,156 questions available',
              backgroundColor: Color(0xFFFF5722),
              onTap: () {
                Navigator.of(context).push(
                  _createRoute(
                    context,
                    'Mechanical Engineering',
                    Color(0xFFFF5722),
                    Icons.settings,
                    '3,156 questions available',
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            FacultyCard(
              icon: Icons.flash_on,
              title: 'Electrical Engineering',
              subtitle: '1,784 questions available',
              backgroundColor: Color(0xFF9C27B0),
              onTap: () {
                Navigator.of(context).push(
                  _createRoute(
                    context,
                    'Electrical Engineering',
                    Color(0xFF9C27B0),
                    Icons.flash_on,
                    '1,784 questions available',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute(
    BuildContext context,
    String title,
    Color color,
    IconData icon,
    String subtitle,
  ) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          FacultyDetailsScreen(
            facultyName: title,
            facultyColor: color,
            facultyIcon: icon,
            questionCount: subtitle,
          ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var slideTween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var fadeTween = Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
