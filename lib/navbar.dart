// import 'package:flutter/material.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const CustomBottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: Colors.greenAccent,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 8,
//             offset: Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
          
//           _buildNavItem(Icons.home, 'Home', 0),
//           _buildNavItem(Icons.check_circle, 'Statement', 1),
//           _buildNavItem(Icons.support_agent, 'Support', 2),
//           _buildNavItem(Icons.more_horiz, 'More', 3),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, String label, int index) {
//     final isSelected = index == currentIndex;
//     return GestureDetector(
//       onTap: () => onTap(index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Use a circle background for the icon if selected
//           Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.green : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: isSelected ? Colors.white : Colors.grey[300],
//               size: 24,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey[300],
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
