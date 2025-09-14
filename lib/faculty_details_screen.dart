import 'package:exampleapk/core/colors.dart';
import 'package:exampleapk/faculty_selection_screen.dart';
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
  State createState() => _FacultyDetailsScreenState();
}

class _FacultyDetailsScreenState extends State<FacultyDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _contentController;
  late Animation _headerScale;
  late Animation _contentSlide;
  late Animation _contentFade;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerScale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.elasticOut),
    );

    _contentSlide = Tween(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
    );

    _contentFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    // Start animations with delay
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _headerController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    _contentController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Animated Header
            AnimatedBuilder(
              animation: _headerController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _headerScale.value,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.facultyColor,
                          widget.facultyColor.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
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
                            const Spacer(),
                            const Icon(Icons.more_vert, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 40),
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
                        const SizedBox(height: 20),
                        Text(
                          widget.facultyName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
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
                );
              },
            ),

            // Animated Content with TopicCards
            Expanded(
              child: AnimatedBuilder(
                animation: _contentController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _contentSlide.value),
                    child: Opacity(
                      opacity: _contentFade.value,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Study Topics',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: CColors.textColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Using TopicCard widgets
                              TopicCard(
                                title: 'Data Structures & Algorithms',
                                questionCount: '245 questions',
                                facultyColor: widget.facultyColor,
                                onTap: () {
                                  // Handle tap if needed
                                },
                              ),
                              const SizedBox(height: 12),
                              TopicCard(
                                title: 'Object Oriented Programming',
                                questionCount: '189 questions',
                                facultyColor: widget.facultyColor,
                                onTap: () {
                                  // Handle tap if needed
                                },
                              ),
                              const SizedBox(height: 12),
                              TopicCard(
                                title: 'Database Management System',
                                questionCount: '156 questions',
                                facultyColor: widget.facultyColor,
                                onTap: () {
                                  // Handle tap if needed
                                },
                              ),
                              const SizedBox(height: 12),
                              TopicCard(
                                title: 'Computer Networks',
                                questionCount: '198 questions',
                                facultyColor: widget.facultyColor,
                                onTap: () {
                                  // Handle tap if needed
                                },
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Starting ${widget.facultyName} studies!',
                                        ),
                                        backgroundColor: widget.facultyColor,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.facultyColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Start Studying',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
