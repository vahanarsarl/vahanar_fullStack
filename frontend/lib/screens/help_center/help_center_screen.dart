import 'package:flutter/material.dart';
import 'package:vahanar_front/widgets/bottom_nav_bar.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool _showFAQ = true; // Variable pour gérer l'affichage entre FAQ et Contact Us

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc comme dans l'image
      body: SafeArea(
        child: Column(
          children: [
            // Header personnalisé
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              color: const Color(0xFF2A4D50), // Couleur verte foncée
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const Text(
                    'HELP CENTER',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'LeagueSpartan-Bold',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            // Barre de recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Fond blanc comme dans l'image
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search by topic',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'LeagueSpartan-Light',
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.grey),
                  ],
                ),
              ),
            ),
            // Boutons FAQ et Contact Us
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showFAQ = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _showFAQ ? const Color(0xFF2A4D50) : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'FAQ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'LeagueSpartan-Bold',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showFAQ = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_showFAQ ? const Color(0xFF2A4D50) : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'CONTACT US',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'LeagueSpartan-Bold',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // Contenu conditionnel : FAQ ou Contact Us
            Expanded(
              child: _showFAQ ? _buildFAQContent() : _buildContactUsContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1), // Ajuste l'index selon ta navigation
    );
  }

  // Contenu FAQ
  Widget _buildFAQContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ExpansionTile(
            title: const Text(
              'Lorem ipsum dolor sit amet?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'LeagueSpartan-Bold',
              ),
            ),
            trailing: Icon(
              Icons.expand_more,
              color: const Color(0xFF2A4D50),
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'LeagueSpartan-Light',
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Contenu Contact Us
  Widget _buildContactUsContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        _buildContactItem(Icons.headset, 'Customer Service'),
        _buildContactItem(Icons.web, 'Website'),
        _buildContactItem(Icons.phone, 'Whatsapp'),
        _buildContactItem(Icons.facebook, 'Facebook'),
        _buildContactItem(Icons.camera_alt, 'Instagram'),
      ],
    );
  }

  // Méthode pour les éléments de Contact Us
  Widget _buildContactItem(IconData icon, String title) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'LeagueSpartan-Light',
          color: Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.expand_more,
        color: const Color(0xFF2A4D50),
      ),
      children: const [], // Ajoute du contenu si nécessaire
    );
  }
}