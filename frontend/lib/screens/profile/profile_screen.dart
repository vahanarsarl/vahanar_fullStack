import 'package:flutter/material.dart';
import 'package:vahanar_front/widgets/bottom_nav_bar.dart'; // Importer la barre de navigation

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Column(
                  children: [
                    _buildOptionTile(
                      icon: Icons.credit_card,
                      title: 'Driving licence',
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    _buildOptionTile(
                      icon: Icons.help_outline,
                      title: 'Help center',
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    _buildOptionTile(
                      icon: Icons.calendar_today,
                      title: 'My reservations',
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    _buildOptionTile(
                      icon: Icons.lock,
                      title: 'General conditions',
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    _buildOptionTile(
                      icon: Icons.logout,
                      title: 'Log out',
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/sign_in');
                      },
                    ),
                    const Spacer(),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFF2A4D50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'LeagueSpartan-Bold',
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 16),
          // Centrer l'image, le nom et "Edit Profile"
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image de profil carrée avec coins arrondis
              Container(
                width: 80, // Agrandir l'image
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), // Coins arrondis (radius 8)
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile_picture.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Nom "John Doe" agrandi
              const Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24, // Taille agrandie
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'LeagueSpartan-Bold',
                ),
              ),
              const SizedBox(height: 4),
              // "Edit Profile" en gris, non souligné, agrandi
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16, // Taille agrandie
                    color: Colors.grey, // En gris
                    fontFamily: 'LeagueSpartan-Light',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return AnimatedOptionTile(
      icon: icon,
      title: title,
      onTap: onTap,
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        // Ligne avec épaisseur 4 et couleur teal
        Container(
          height: 4, // Épaisseur de 4
          color: const Color(0xFF2A4D50), // Couleur teal
        ),
        const SizedBox(height: 16),
        const Text(
          'Get to know more about US :',
          style: TextStyle(
            fontSize: 16, // Taille agrandie
            color: Color(0xFF2A4D50),
            fontFamily: 'LeagueSpartan-Light',
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset(
                'assets/icones/facebook.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: Image.asset(
                'assets/icones/insta.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16), // Pas de marge blanche excessive
      ],
    );
  }
}

// Widget personnalisé pour gérer l'animation de flottement
class AnimatedOptionTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AnimatedOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  _AnimatedOptionTileState createState() => _AnimatedOptionTileState();
}

class _AnimatedOptionTileState extends State<AnimatedOptionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0), // Décalage vers la droite
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isTapped = true;
    });
    _controller.forward().then((_) {
      widget.onTap(); // Appeler la navigation après l'animation
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: _isTapped ? Colors.grey.shade200 : Colors.transparent, // Effet de surbrillance
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 30, // Taille agrandie
                color: Colors.black,
              ),
              const SizedBox(width: 16),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18, // Taille agrandie
                  color: Colors.black,
                  fontFamily: 'LeagueSpartan-Light',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}