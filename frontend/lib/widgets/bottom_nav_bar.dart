import 'package:flutter/material.dart';
import 'package:vahanar_front/screens/home/home_screen.dart';
import 'package:vahanar_front/screens/home/search_screen.dart';
import 'package:vahanar_front/screens/profile/profile_screen.dart';
class BottomNavBar extends StatefulWidget {
  final int selectedIndex; // Paramètre pour l'index actif

  const BottomNavBar({super.key, this.selectedIndex = 1}); // Par défaut, "Home" est sélectionné

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // Initialiser avec l'index passé
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Gérer la navigation en fonction de l'index
    if (index == 0 && ModalRoute.of(context)?.settings.name != '/search') {
      // Naviguer vers SearchScreen si l'utilisateur n'est pas déjà sur cette page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    } else if (index == 1 && ModalRoute.of(context)?.settings.name != '/home') {
      // Naviguer vers HomeScreen si l'utilisateur n'est pas déjà sur cette page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 2 && ModalRoute.of(context)?.settings.name != '/profile') {
      // Naviguer vers ProfileScreen si l'utilisateur n'est pas déjà sur cette page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: [
          _buildNavItem('search', 'Search', 0),
          _buildNavItem('home', 'Home', 1),
          _buildNavItem('person', 'Profile', 2),
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
        unselectedItemColor: const Color(0xFF9DB2CE),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconName, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: const Offset(0, -30), // Augmenter l'offset pour que le cercle monte davantage
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Cercle blanc (toujours présent, plus grand pour l'icône active)
                Container(
                  width: isSelected ? 70 : 50, // Augmenter la taille du cercle blanc pour l'icône active
                  height: isSelected ? 70 : 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                // Cercle bleu (uniquement pour l'icône active)
                if (isSelected)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF004852), // Couleur du bouton actif
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                // Icône
                Image.asset(
                  isSelected
                      ? 'assets/icons/${iconName}_b.png' // Icône blanche si actif
                      : 'assets/icons/${iconName}.png', // Icône normale sinon
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8), // Augmenter l'espace entre l'icône et la ligne
          // Ligne de terminaison en bas
          Container(
            width: 20,
            height: 1, // Réduire la hauteur pour une ligne plus fine
            color: isSelected ? Colors.white : const Color(0xFF9DB2CE),
          ),
        ],
      ),
      label: label,
    );
  }
}