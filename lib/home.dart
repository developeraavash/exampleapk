import 'package:flutter/material.dart';
import 'widgets/syllabus_card.dart';
import 'widgets/questions_card.dart';
import 'widgets/important_questions_card.dart';

class CColors {
  static const Color primaryColor = Color(0xFF667EEA);
  static const Color primaryLight = Color(0xFF764BA2);
  static const Color secondaryColor = Color(0xFF5A67D8);
  static const Color accentColor = Color(0xFFF093FB);
  static const Color teal = Color(0xFF4FACFE);
  static const Color white = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF424242);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color shadowColor = Color(0x1A000000);
  static const Color green = Color(0xFF56CCF2);
  static const Color red = Color(0xFFFF6B6B);
  static const Color purple = Color(0xFF9C88FF);
  static const Color yellow = Color(0xFFFFC048);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;
  bool _isNavBarVisible = true;
  double _lastScrollOffset = 0;
  
  late AnimationController _animationController;
  late AnimationController _appBarController;
  late AnimationController _navBarController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _appBarSlideAnimation;
  late Animation<Offset> _navBarSlideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _appBarController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _navBarController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _appBarSlideAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _appBarController,
      curve: Curves.easeInOut,
    ));

    _navBarSlideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _navBarController,
      curve: Curves.easeInOut,
    ));

    // Start with bars visible
    _appBarController.forward();
    _navBarController.forward();
    _animationController.forward();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double delta = offset - _lastScrollOffset;

      // Hide when scrolling down (more sensitive threshold)
      if (delta > 3 && offset > 80) {
        if (_isAppBarVisible || _isNavBarVisible) {
          setState(() {
            _isAppBarVisible = false;
            _isNavBarVisible = false;
          });
          _appBarController.reverse();
          _navBarController.reverse();
        }
      }
      // Show when scrolling up (more sensitive threshold)
      else if (delta < -3 || offset <= 30) {
        if (!_isAppBarVisible || !_isNavBarVisible) {
          setState(() {
            _isAppBarVisible = true;
            _isNavBarVisible = true;
          });
          _appBarController.forward();
          _navBarController.forward();
        }
      }

      _lastScrollOffset = offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _appBarController.dispose();
    _navBarController.dispose();
    super.dispose();
  }

  Widget _buildSyllabusCard() {
    return SyllabusCard(fadeAnimation: _fadeAnimation);
  }

  Widget _buildQuestionsCard() {
    return QuestionsCard(
      fadeAnimation: _fadeAnimation,
      totalQuestions: 45, // You can adjust this number as needed
    );
  }

  Widget _buildImportantQuestionsCard() {
    return ImportantQuestionsCard(fadeAnimation: _fadeAnimation);
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: const [CColors.white, CColors.backgroundColor],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.library_books, 
                          color: CColors.primaryColor, size: 28),
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
                      _buildStudyMaterialItem(Icons.picture_as_pdf, 'PDFs', CColors.red),
                      _buildStudyMaterialItem(Icons.video_library, 'Videos', CColors.purple),
                      _buildStudyMaterialItem(Icons.quiz, 'Quizzes', CColors.green),
                      _buildStudyMaterialItem(Icons.notes, 'Notes', CColors.yellow),
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
      backgroundColor: CColors.backgroundColor,
      body: Stack(
        children: [
          // Main content that can extend behind app bar and nav bar
          Positioned.fill(
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: kToolbarHeight + MediaQuery.of(context).padding.top + 8,
                bottom: 88, // Bottom padding for nav bar
              ),
              children: [
                _buildSyllabusCard(),
                _buildQuestionsCard(),
                _buildImportantQuestionsCard(),
                _buildStudyMaterialsCard(),
                SizedBox(height: 20), // Extra space at bottom
              ],
            ),
          ),
          
          // Floating App Bar
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _appBarSlideAnimation,
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: _buildAnimatedAppBar(),
              ),
            ),
          ),
          
          // Floating Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _navBarSlideAnimation,
              child: _buildAnimatedNavBar(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedAppBar() {
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [CColors.primaryColor, CColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu_rounded, color: CColors.white),
              onPressed: () {},
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                  _getAppBarTitle(),
                  key: ValueKey(_selectedIndex),
                  style: TextStyle(
                    color: CColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search_rounded, color: CColors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications_none_rounded, color: CColors.white),
              onPressed: () {},
            ),
          ],
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
                  colors: [CColors.primaryColor, CColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
                  width: (notchRadius - 4) * 2,
                  height: (notchRadius - 4) * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [CColors.accentColor, CColors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CColors.accentColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.smart_toy_rounded,
                    color: CColors.white,
                    size: 28,
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
