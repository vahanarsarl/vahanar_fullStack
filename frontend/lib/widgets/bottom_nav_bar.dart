import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: [
          _buildNavItem('search', 'Search', 0),
          _buildNavItem('home', 'Home', 1),
          _buildNavItem('profile', 'Profile', 2),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF9DB2CE),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconName, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isSelected)
            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF004852), // Couleur du bouton actif
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF004852).withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: isSelected ? -10 : 0),
            child: Image.asset(
              isSelected
                  ? 'assets/icons/${iconName}_white.png' // Icône blanche si sélectionné
                  : 'assets/icons/${iconName}.png', // Icône normale sinon
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      label: label,
    );
  }
}
