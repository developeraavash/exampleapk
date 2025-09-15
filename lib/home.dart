import 'package:flutter/material.dart';

class CColors {
  static const Color primaryColor = Color(0xFF4361EE);
  static const Color primaryLight = Color(0xFF4895EF);
  static const Color secondaryColor = Color(0xFF3A0CA3);
  static const Color accentColor = Color(0xFFF72585);
  static const Color teal = Color(0xFF4CC9F0);
  static const Color white = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF424242);
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color shadowColor = Color(0x1A000000);
  static const Color green = Color(0xFF4CAF50);
  static const Color red = Color(0xFFF44336);
  static const Color purple = Color(0xFF9C27B0);
  static const Color yellow = Color(0xFFFFC107);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;
  bool _isNavBarVisible = true;
  double _lastScrollOffset = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;

      if (offset > _lastScrollOffset && offset > 100) {
        if (_isAppBarVisible || _isNavBarVisible) {
          setState(() {
            _isAppBarVisible = false;
            _isNavBarVisible = false;
          });
        }
      } else if (offset < _lastScrollOffset || offset < 50) {
        if (!_isAppBarVisible || !_isNavBarVisible) {
          setState(() {
            _isAppBarVisible = true;
            _isNavBarVisible = true;
          });
        }
      }

      _lastScrollOffset = offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildSyllabusCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [CColors.primaryLight, CColors.primaryColor],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.menu_book, color: Colors.white),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Syllabus",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Complete course syllabus for this semester",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: 0.65,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "65% completed",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          "VIEW DETAILS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CColors.primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionsCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CColors.accentColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.quiz, color: CColors.accentColor),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Practice Questions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CColors.darkGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Test your knowledge with these practice questions",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildChapterChip("Chapter 1: 12 questions", CColors.green),
                    _buildChapterChip(
                      "Chapter 2: 8 questions",
                      CColors.primaryColor,
                    ),
                    _buildChapterChip(
                      "Chapter 3: 15 questions",
                      CColors.purple,
                    ),
                    _buildChapterChip("Chapter 4: 10 questions", CColors.teal),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CColors.accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shadowColor: CColors.accentColor.withOpacity(0.4),
                      elevation: 5,
                    ),
                    child: Text(
                      'Start Practice',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
  }

  Widget _buildChapterChip(String text, Color color) {
    return Chip(
      backgroundColor: color.withOpacity(0.1),
      label: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: BorderSide(color: color.withOpacity(0.2)),
    );
  }

  Widget _buildImportantQuestionsCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [CColors.red, CColors.accentColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.star, color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Most Important Questions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CColors.darkGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Focus on these high-priority questions for exams",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                SizedBox(height: 20),
                _buildImportantQuestionItem(
                  "Chapter 1: Key Concepts",
                  Icons.looks_one,
                ),
                Divider(height: 20, color: Colors.grey[200]),
                _buildImportantQuestionItem(
                  "Chapter 2: Problem Solving",
                  Icons.looks_two,
                ),
                Divider(height: 20, color: Colors.grey[200]),
                _buildImportantQuestionItem(
                  "Chapter 3: Advanced Topics",
                  Icons.looks_3,
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "View All Important Questions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CColors.primaryColor,
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
  }

  Widget _buildImportantQuestionItem(String title, IconData icon) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: CColors.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: CColors.primaryColor),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildStudyMaterialsCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CColors.purple.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.library_books, color: CColors.purple),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Study Materials",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CColors.darkGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Access all your study resources in one place",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStudyMaterialItem(
                      Icons.picture_as_pdf,
                      "PDF Notes",
                      CColors.primaryColor,
                    ),
                    _buildStudyMaterialItem(
                      Icons.video_library,
                      "Videos",
                      CColors.green,
                    ),
                    _buildStudyMaterialItem(
                      Icons.audiotrack,
                      "Audio",
                      CColors.accentColor,
                    ),
                    _buildStudyMaterialItem(
                      Icons.article,
                      "Articles",
                      CColors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudyMaterialItem(IconData icon, String text, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        SizedBox(height: 8),
        Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isAppBarVisible ? _buildAnimatedAppBar() : null,
      backgroundColor: Colors.grey[100],
      body: ListView(
        controller: _scrollController,
        children: [
          SizedBox(height: 8),
          _buildSyllabusCard(),
          _buildQuestionsCard(),
          _buildImportantQuestionsCard(),
          _buildStudyMaterialsCard(),
          _buildSyllabusCard(),
          _buildQuestionsCard(),
        ],
      ),
      bottomNavigationBar: _isNavBarVisible
          ? _buildAnimatedNavBar(context)
          : null,
    );
  }

  PreferredSizeWidget _buildAnimatedAppBar() {
    return AppBar(
      backgroundColor: CColors.primaryColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      title: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _selectedIndex == 0
            ? Text(
                'Study & Learning App',
                key: ValueKey('home-title'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              )
            : Text(
                _getAppBarTitle(),
                key: ValueKey('other-title'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
      ),
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.menu_rounded), onPressed: () {}),
      actions: [
        IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
        IconButton(
          icon: Icon(Icons.notifications_none_rounded),
          onPressed: () {},
        ),
        SizedBox(width: 8),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [CColors.primaryColor, CColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Study & Learning App';
      case 1:
        return 'Syllabus';
      case 2:
        return 'AI Assistant';
      case 3:
        return 'Practice Tests';
      case 4:
        return 'Profile';
      default:
        return 'Study & Learning App';
    }
  }

  Widget _buildAnimatedNavBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notchRadius = 40.0;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background with notch
          ClipPath(
            clipper: _NavBarClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [CColors.secondaryColor, CColors.primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: CColors.shadowColor,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
            ),
          ),

          // Floating AI Chat Button
          Positioned(
            top: -notchRadius + 3,
            left: size.width / 2 - notchRadius + 4,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: GestureDetector(
                onTap: () => setState(() => _selectedIndex = 2),
                child: Container(
                  width: 1.8 * notchRadius,
                  height: 1.8 * notchRadius,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [CColors.accentColor, CColors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: CColors.accentColor.withOpacity(0.5),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: CColors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Navigation Items
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_rounded, 'Home', 0),
                _buildNavItem(Icons.menu_book_rounded, 'Syllabus', 1),
                SizedBox(width: 2 * notchRadius),
                _buildNavItem(Icons.quiz_rounded, 'Tests', 3),
                _buildNavItem(Icons.person_rounded, 'Profile', 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? CColors.white : Colors.white.withOpacity(0.7),
              size: 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? CColors.white : Colors.white.withOpacity(0.7),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double notchRadius = 40.0;
    final double centerX = size.width / 2;

    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    final double notchStartX = centerX - notchRadius - 10;
    path.lineTo(notchStartX, 0);

    path.quadraticBezierTo(notchStartX + 10, 0, centerX - notchRadius, 0);

    path.arcTo(
      Rect.fromCircle(center: Offset(centerX, 0), radius: notchRadius),
      3.14,
      -3.14,
      false,
    );

    final double notchEndX = centerX + notchRadius + 10;
    path.quadraticBezierTo(centerX + notchRadius, 0, notchEndX, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
