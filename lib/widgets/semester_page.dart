import 'package:exampleapk/core/colors.dart';
import 'package:flutter/material.dart';

class SemesterScreen extends StatefulWidget {
  final String semesterName;
  final String facultyName;
  final Color facultyColor;
  final IconData facultyIcon;

  const SemesterScreen({
    Key? key,
    required this.semesterName,
    required this.facultyName,
    required this.facultyColor,
    required this.facultyIcon,
  }) : super(key: key);

  @override
  _SemesterScreenState createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen>
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
    final subjects = [
      'Subject 1',
      'Subject 2',
      'Subject 3',
      'Subject 4',
      'Subject 5',
    ];

    return Scaffold(
      backgroundColor: CColors.white,
      body: Column(
        children: [
          // Animated header similar to your faculty details style
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
                        widget.facultyColor.withOpacity(0.8),
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
                                color: Colors.white.withOpacity(0.2),
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
                      // Hero with semester name (scrollable if long)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Hero(
                          tag: 'semesterName_${widget.semesterName}',
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),

                              child: Text(
                                widget.semesterName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),

          // Content with subjects
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
                      child: ListView(
                        children: [
                          const Text(
                            'Subjects',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Subjects list
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: subjects.length,
                              itemBuilder: (context, index) {
                                final subject = subjects[index];
                                return Container(
                                  width: 120,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      subject,
                                      style: const TextStyle(
                                        color: Colors.white,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
