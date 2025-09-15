import 'package:flutter/material.dart';

class CColors {
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color white = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color backgroundColor = Color(0xFF222222);
  static const Color shadowColor = Colors.black26;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;
  bool _isNavBarVisible = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;

      if (offset > _lastScrollOffset && offset > 0) {
        // Scrolling down
        if (_isAppBarVisible || _isNavBarVisible) {
          setState(() {
            _isAppBarVisible = false;
            _isNavBarVisible = false;
          });
        }
      } else if (offset < _lastScrollOffset) {
        // Scrolling up
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
    super.dispose();
  }

  Widget _buildListItem(String title) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[200],
      child: ListTile(
        leading: Icon(Icons.info, color: CColors.primaryColor),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isAppBarVisible
          ? AppBar(
              title: Text('Travel & Ticketing'),
              backgroundColor: Colors.pink,
            )
          : null,
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 200,
        itemBuilder: (_, index) => _buildListItem('Item ${index + 1}'),
      ),
      bottomNavigationBar: _isNavBarVisible
          ? _buildNotchedNavBar(context)
          : null,
    );
  }

  Widget _buildNotchedNavBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notchRadius = 40.0; // same as in clipper

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The custom clip path with a smooth curve and notch
        ClipPath(
          clipper: _NavBarClipper(),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black,
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
        // Floating icon aligned with the notch
        Positioned(
          top: -notchRadius + 3, // slight adjustment for perfect fit
          left: size.width / 2 - notchRadius + 4,
          child: GestureDetector(
            onTap: () => setState(() => _selectedIndex = 2),
            child: Container(
              width: 1.8 * notchRadius,
              height: 1.8 * notchRadius,
              decoration: BoxDecoration(
                color: CColors.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: CColors.shadowColor,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(Icons.camera_alt, color: CColors.white, size: 24),
              ),
            ),
          ),
        ),
        // Side navigation icons
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.list_alt, 'Statement', 1),
              SizedBox(width: 2 * notchRadius), // space for floating icon
              _buildNavItem(Icons.support_agent, 'Support', 2),
              _buildNavItem(Icons.more_horiz, 'More', 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? CColors.white : Colors.grey, size: 24),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? CColors.white : Colors.grey,
              fontSize: 12,
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
    final double notchRadius = 40.0; // radius of the notch
    final double centerX = size.width / 2;

    // Start from bottom left
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    // Draw the top edge with a smooth curve and a notch
    // From left to start of notch
    final double notchStartX = centerX - notchRadius - 10;
    path.lineTo(notchStartX, 0);

    // Draw a quadratic curve into the notch
    path.quadraticBezierTo(notchStartX + 10, 0, centerX - notchRadius, 0);

    // Create the notch (semi-circular dip)
    path.arcTo(
      Rect.fromCircle(center: Offset(centerX, 0), radius: notchRadius),
      3.14, // start at 180 degrees
      -3.14, // sweep 180 degrees downward
      false,
    );

    // Exit the notch with a smooth curve
    final double notchEndX = centerX + notchRadius + 10;
    path.quadraticBezierTo(centerX + notchRadius, 0, notchEndX, 0);

    // Complete the top edge on the right side
    path.lineTo(size.width, 0);

    // Finish the rectangle
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
