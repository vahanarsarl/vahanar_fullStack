import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vahanar_front/providers/auth_provider.dart';
import 'package:vahanar_front/widgets/bottom_nav_bar.dart';

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
                      onTap: () {
                        Navigator.pushNamed(context, '/driving_licence');
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildOptionTile(
                      icon: Icons.help_outline,
                      title: 'Help center',
                      onTap: () {
                        Navigator.pushNamed(context, '/help_center');
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildOptionTile(
                      icon: Icons.calendar_today,
                      title: 'My reservations',
                      onTap: () {
                        Navigator.pushNamed(context, '/my_reservations'); // Navigation vers ReservationsHistoryScreen
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildOptionTile(
                      icon: Icons.lock,
                      title: 'General conditions',
                      onTap: () {
                        Navigator.pushNamed(context, '/general_conditions');
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildOptionTile(
                      icon: Icons.logout,
                      title: 'Log out',
                      onTap: () async {
                        await Provider.of<AuthProvider>(context, listen: false).logout();
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
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final fullName = user != null ? '${user.firstName} ${user.lastName}' : 'John Doe';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile_picture.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'LeagueSpartan-Bold',
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontFamily: 'LeagueSpartan-Light',
                        ),
                      ),
                    ),
                  ],
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
        Container(
          height: 4,
          color: const Color(0xFF2A4D50),
        ),
        const SizedBox(height: 16),
        const Text(
          'Get to know more about US :',
          style: TextStyle(
            fontSize: 16,
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
                'assets/icons/facebook.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: Image.asset(
                'assets/icons/insta.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

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
      end: const Offset(0.1, 0),
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
      widget.onTap();
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _isTapped = false;
          });
          _controller.reverse();
        }
      });
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
            color: _isTapped ? Colors.grey.shade200 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 30,
                color: Colors.black,
              ),
              const SizedBox(width: 16),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
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