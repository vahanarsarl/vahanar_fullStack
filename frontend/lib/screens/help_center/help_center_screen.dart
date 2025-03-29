import 'package:flutter/material.dart';
import 'package:vahanar_front/widgets/bottom_nav_bar.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool _showFAQ = true;
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header personnalisé
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              color: const Color(0xFF2A4D50),
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
                      decorationColor: Colors.white,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
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
                          _expandedIndex = null;
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
                          _expandedIndex = null;
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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }

  // Contenu FAQ
  Widget _buildFAQContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container( // Utilisation de Container au lieu de Card pour le style
          decoration: BoxDecoration(
            color: Colors.grey[50], // Fond gris clair
            borderRadius: BorderRadius.circular(25), // Bords arrondis
            border: Border.all(
              color: Colors.grey.shade300, // Bordure discrète
              width: 1,
            ),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0), // Espacement entre les cases
          child: ExpansionTile(
            initiallyExpanded: index == _expandedIndex,
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
            onExpansionChanged: (bool expanded) {
              setState(() {
                if (expanded) {
                  _expandedIndex = index;
                } else {
                  _expandedIndex = null;
                }
              });
            },
          ),
        );
      },
    );
  }

  // Contenu Contact Us
  Widget _buildContactUsContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildContactItem(index);
      },
    );
  }

  // Méthode pour les éléments de Contact Us
  Widget _buildContactItem(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50], // Fond gris clair
        borderRadius: BorderRadius.circular(25), // Bords arrondis
        border: Border.all(
          color: Colors.grey.shade300, // Bordure discrète
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Espacement entre les cases
      child: ExpansionTile(
        initiallyExpanded: index == _expandedIndex,
        leading: Padding(
          padding: const EdgeInsets.only(right: 8.0), //Espacement a droite de l'icone
          child: Image.asset(
            'assets/icons/${_getContactIconName(index)}.png', // Chemin de l'icône
            width: 24, // Ajustez la taille selon vos besoins
            height: 24,
            color: const Color(0xFF2A4D50), // Ajout de la couleur verte foncée
          ),
        ),
        title: Text(
          _getContactTitle(index),
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
        children: const [],
        onExpansionChanged: (bool expanded) {
          setState(() {
            if (expanded) {
              _expandedIndex = index;
            } else {
              _expandedIndex = null;
            }
          });
        },
      ),
    );
  }

  String _getContactIconName(int index) {
    // Correspond aux noms des fichiers d'icônes dans votre dossier assets/icons
    switch (index) {
      case 0:
        return 'eclipse1';
      case 1:
        return 'eclipse2';
      case 2:
        return 'eclipse3';
      case 3:
        return 'eclipse4';
      case 4:
        return 'eclipse5';
      default:
        return 'error'; // Icône par défaut
    }
  }

  String _getContactTitle(int index) {
    switch (index) {
      case 0:
        return 'Customer Service';
      case 1:
        return 'Website';
      case 2:
        return 'Whatsapp';
      case 3:
        return 'Facebook';
      case 4:
        return 'Instagram';
      default:
        return 'Unknown';
    }
  }
}