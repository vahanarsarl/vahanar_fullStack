import 'package:flutter/material.dart';
import 'package:vahanar_front/constants.dart'; // Import des constantes
import 'package:vahanar_front/theme.dart'; // Import du thème
import 'package:vahanar_front/widgets/custom_button.dart'; // Bouton personnalisé
import 'package:vahanar_front/widgets/custom_text_field.dart'; // Champ de texte personnalisé
import 'package:vahanar_front/widgets/bottom_nav_bar.dart'; // Barre de navigation
import 'package:vahanar_front/animations/carousel_animation.dart'; // Import corrigé
import 'package:vahanar_front/screens/home/search_screen.dart'; // Import de la nouvelle page de recherche

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0; // Pour suivre l'index du carrousel "Recent searches"
  int _currentVahanarCarouselIndex = 0; // Pour suivre l'index du carrousel "VAHANAR"

  final List<Map<String, String>> recentSearches = [
    {'title': 'Mohamed V Intl Airport, casab...', 'date': 'Mar 25 – Mar 27'},
    {'title': 'Mohamed V Intl Airport, casab...', 'date': 'Mar 25 – Mar 27'},
    {'title': 'Paris Charles de Gaulle, FRA', 'date': 'Apr 01 – Apr 05'},
    {'title': 'London Heathrow, UK', 'date': 'Apr 10 – Apr 15'},
    {'title': 'New York JFK, USA', 'date': 'Apr 20 – Apr 25'},
    {'title': 'Tokyo Narita, JPN', 'date': 'May 01 – May 05'},
  ];

  // Limite les recherches affichées à 5 pour les points
  List<Map<String, String>> get displayedRecentSearches =>
      recentSearches.length > 5 ? recentSearches.sublist(0, 5) : recentSearches;

  // Méthode pour naviguer vers SearchScreen et récupérer les données
  Future<void> _navigateToSearchScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );

    // Si des données sont renvoyées, les ajouter à la liste "Recent searches"
    if (result != null && result is Map<String, String>) {
      setState(() {
        recentSearches.insert(0, result);
        if (recentSearches.length > 5) {
          recentSearches.removeLast(); // Limite à 5 en boucle
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir la largeur de l'écran pour un padding dynamique
    double screenWidth = MediaQuery.of(context).size.width;

    // Construction des items pour le carrousel horizontal
    List<Widget> recentSearchWidgets = displayedRecentSearches.map((item) {
      return _buildRecentSearchCard(item['title']!, item['date']!);
    }).toList();

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête personnalisé avec "WELCOME" et icône de notification
              Container(
                width: screenWidth, // Occupe toute la largeur de l'écran
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF004852), // Vert foncé basé sur l'image
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24), // Rayon de 24 en bas à gauche
                    bottomRight: Radius.circular(24), // Rayon de 24 en bas à droite
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 2.0), // Espacement pour la bordure
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white, width: 1.0)), // Bordure de 1 pixel
                      ),
                      child: Text(
                        'WELCOME',
                        style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {
                        // Action pour les notifications
                      },
                      tooltip: 'Notifications', // Ajout pour l'accessibilité
                    ),
                  ],
                ),
              ),
              // Padding dynamique appliqué uniquement au contenu en dessous
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // 5% de la largeur de chaque côté
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),

                    // Titre avant la barre de recherche
                    Text(
                      'Plan Your Trip',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),

                    // Section "Plan Your Next Trip" avec navigation vers SearchScreen
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: GestureDetector(
                        onTap: () {
                          // Naviguer vers SearchScreen et attendre le résultat
                          _navigateToSearchScreen(context);
                        },
                        child: Container(
                          width: double.infinity, // Occupe toute la largeur
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  icon: Icons.search,
                                  hintText: 'Plan Your Next Trip\nMake a reservation',
                                  hintStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.black54,
                                  ),
                                  controller: TextEditingController(),
                                  keyboardType: TextInputType.text,
                                  enabled: false, // Désactiver l'entrée pour que le clic redirige
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward, color: AppConstants.primaryColor),
                                onPressed: () {
                                  // Naviguer vers SearchScreen et attendre le résultat
                                  _navigateToSearchScreen(context);
                                },
                                tooltip: 'Go to Search', // Ajout pour l'accessibilité
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section "Recent searches" avec carrousel horizontal
                    Text(
                      'Recent searches',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200, // Hauteur fixe pour le carrousel horizontal
                      child: PageView(
                        scrollDirection: Axis.horizontal, // Défilement horizontal
                        onPageChanged: (index) {
                          setState(() {
                            _currentCarouselIndex = index;
                          });
                        },
                        children: recentSearchWidgets,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Indicateur de page (dots) simplifié
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        displayedRecentSearches.length, // Utiliser directement la longueur
                        (index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentCarouselIndex == index
                                  ? Colors.black // Point actif
                                  : Colors.grey.withOpacity(0.5), // Points inactifs
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section "VAHANAR" avec carrousel horizontal
                    Text(
                      AppConstants.appName.toUpperCase(),
                      style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: CarouselAnimation(
                            items: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/animations/earn.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Text(
                                        'Earn vahanar points for every valuable dollar you spend on rewards and accessories.',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/animations/earn1.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Text(
                                        'Get exclusive discounts on your next rental with Vahanar!',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onPageChanged: (index) {
                              setState(() {
                                _currentVahanarCarouselIndex = index; // Utilise l'index spécifique à VAHANAR
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Indicateur de page (dots) pour VAHANAR
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(2, (index) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentVahanarCarouselIndex == index
                                    ? AppConstants.primaryColor
                                    : Colors.grey.withOpacity(0.5),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Bouton "Need Help?" ajusté
                    GestureDetector(
                      onTap: () {
                        // Action pour "Need Help?"
                      },
                      child: Container(
                        width: double.infinity, // Occupe toute la largeur
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.help_outline, color: Colors.black),
                            Text(
                              'Need Help?',
                              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const Icon(Icons.arrow_forward, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1), // "Home" est actif
    );
  }

  Widget _buildRecentSearchCard(String title, String date) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          Text(
            date,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: 'Continue Reserving',
            onPressed: () {
              // Action pour continuer la réservation
            },
            color: Colors.black,
            isLoading: false,
          ),
        ],
      ),
    );
  }
}