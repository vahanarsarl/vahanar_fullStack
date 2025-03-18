import 'package:flutter/material.dart';
import 'package:vahanar_front/constants.dart'; // Import des constantes
import 'package:vahanar_front/theme.dart'; // Import du thème
import 'package:vahanar_front/widgets/custom_button.dart'; // Bouton personnalisé
import 'package:vahanar_front/widgets/custom_text_field.dart'; // Champ de texte personnalisé
import 'package:vahanar_front/widgets/app_bar.dart'; // AppBar personnalisée
import 'package:vahanar_front/widgets/bottom_nav_bar.dart'; // Barre de navigation
import 'package:vahanar_front/animations/carousel_animation.dart'; // Import corrigé

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0; // Pour suivre l'index du carrousel

  // Liste des éléments du carrousel (images dans assets/animations/)
  final List<Map<String, String>> carouselItems = [
    {
      'image': 'assets/animations/car_keys.jpg', // Chemin corrigé
      'description': 'Earn vahanar points for every valuable dollar you spend on rewards and accessories.',
    },
    {
      'image': 'assets/animations/car_rental.jpg', // Chemin corrigé
      'description': 'Get exclusive discounts on your next rental with Vahanar!',
    },
    // Ajoute d'autres éléments si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    // Construction des items pour le carrousel
    List<Widget> carouselWidgets = carouselItems.asMap().entries.map((entry) {
      int index = entry.key;
      var item = entry.value;
      return AnimatedOpacity(
        opacity: _currentCarouselIndex == index ? 1.0 : 0.7,
        duration: const Duration(milliseconds: 500),
        child: Container(
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
                  image: DecorationImage(
                    image: AssetImage(item['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item['description']!,
                  style: AppTheme.lightTheme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: CustomAppBar(
        title: 'WELCOME',
        textStyle: AppTheme.lightTheme.textTheme.headlineLarge,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Action pour les notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section "Plan Your Next Trip" avec animation native
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
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
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward, color: AppConstants.primaryColor),
                        onPressed: () {
                          Navigator.pushNamed(context, '/search');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Section "Recent searches" avec animation native
              Text(
                'Recent searches',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      child: _buildRecentSearchCard(
                        'Mohamed V Intl Airport, casab...',
                        'Mar 25 – Mar 27',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      child: _buildRecentSearchCard(
                        'Mohamed V Intl Airport, casab...',
                        'Mar 25 – Mar 27',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Section "Vahanar" avec carrousel
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
                      items: carouselWidgets,
                      onPageChanged: (index) {
                        setState(() {
                          _currentCarouselIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Indicateur de page (dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: carouselItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentCarouselIndex == index
                              ? AppConstants.primaryColor
                              : Colors.grey.withOpacity(0.5),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Bouton "Need Help?"
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/help_center');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.help_outline, color: Colors.black),
                      const SizedBox(width: 5),
                      Text(
                        'Need Help?',
                        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
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