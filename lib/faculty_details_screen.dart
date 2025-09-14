import 'package:exampleapk/core/colors.dart';
import 'package:exampleapk/widgets/semester_page.dart';
import 'package:exampleapk/widgets/topic_card.dart';
import 'package:flutter/material.dart';

class FacultyDetailsScreen extends StatefulWidget {
  final String facultyName;
  final Color facultyColor;
  final IconData facultyIcon;
  final String questionCount;

  const FacultyDetailsScreen({
    super.key,
    required this.facultyName,
    required this.facultyColor,
    required this.facultyIcon,
    required this.questionCount,
  });

  @override
  _FacultyDetailsScreenState createState() => _FacultyDetailsScreenState();
}

class _FacultyDetailsScreenState extends State<FacultyDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _contentController;
  late Animation<double> _contentSlide;
  late Animation<double> _contentFade;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _contentSlide = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
    );
    _contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _contentController.forward();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final semesters = List.generate(8, (index) => 'Semester ${index + 1}');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsing header
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    Spacer(),
                    const Icon(Icons.more_vert, color: Colors.white),
                  ],
                ),
              ),
              background: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.facultyColor,
                      widget.facultyColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Hero icon
                    Hero(
                      tag: '${widget.facultyName}_icon',
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          widget.facultyIcon,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Hero with faculty name
                    Hero(
                      tag: 'facultyName_${widget.facultyName}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          widget.facultyName,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.questionCount,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Content: list of semesters
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Semesters',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // List of semester cards
                    ...semesters.map((semester) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SemesterScreen(
                                semesterName: semester,
                                facultyName: widget.facultyName,
                                facultyColor: widget.facultyColor,
                                facultyIcon: Icons.school,
                              ),
                            ),
                          );
                        },
                        child: TopicCard(
                          title: semester,
                          questionCount: '',
                          facultyColor: widget.facultyColor,
                          icon: Icons.school,
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  }
}
