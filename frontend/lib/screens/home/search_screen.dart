import 'package:flutter/material.dart';
import 'package:vahanar_front/constants.dart'; // Import des constantes
import 'package:vahanar_front/theme.dart'; // Import du thème
import 'package:vahanar_front/widgets/bottom_nav_bar.dart'; // Barre de navigation
import 'package:vahanar_front/screens/home/search_result_screen.dart'; // Import de la nouvelle page

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Contrôleurs pour les champs de texte
  final TextEditingController _pickupLocationController = TextEditingController(text: 'Mohamed V Intl Airport, casablanca');
  final TextEditingController _dropoffLocationController = TextEditingController(text: 'Mohamed V Intl Airport, casablanca');
  final TextEditingController _pickupDateController = TextEditingController(text: 'Mar 26 | 23:50 PM');
  final TextEditingController _dropoffDateController = TextEditingController(text: 'Mar 29 | 23:50 PM');
  final TextEditingController _discountCodeController = TextEditingController();

  // Valeurs pour les dropdowns
  String _selectedAge = '25+';
  String _selectedCountry = 'Morocco';

  // Liste des pays avec leurs drapeaux (emojis pour l'instant)
  final List<Map<String, String>> countries = [
    {'name': 'Morocco', 'flag': '🇲🇦'},
    {'name': 'France', 'flag': '🇫🇷'},
    {'name': 'USA', 'flag': '🇺🇸'},
    {'name': 'UK', 'flag': '🇬🇧'},
    {'name': 'Japan', 'flag': '🇯🇵'},
  ];

  @override
  void dispose() {
    _pickupLocationController.dispose();
    _dropoffLocationController.dispose();
    _pickupDateController.dispose();
    _dropoffDateController.dispose();
    _discountCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // En-tête
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color(0xFF004852),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  // Colonne pour aligner l'icône de retour et le titre à gauche
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context); // Retour à HomeScreen
                        },
                      ),
                      Text(
                        'RESERVATION',
                        style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Contenu principal
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Pick-up Location
                      _buildTextField(
                        icon: Icons.location_on,
                        controller: _pickupLocationController,
                        label: 'Pick-up Location',
                      ),
                      const SizedBox(height: 30), // Plus d'espace entre les cases
                      // Drop-off Location (sans checkbox)
                      _buildTextField(
                        icon: Icons.location_on,
                        controller: _dropoffLocationController,
                        label: 'Drop-off Location',
                      ),
                      const SizedBox(height: 30), // Plus d'espace entre les cases
                      // Pick-up Details et Drop-off Details (côte à côte)
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              icon: Icons.calendar_today,
                              controller: _pickupDateController,
                              label: 'Pick-up Details',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              icon: Icons.calendar_today,
                              controller: _dropoffDateController,
                              label: 'Drop-off Details',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30), // Plus d'espace entre les cases
                      // Age et Country of Residence (côte à côte)
                      Row(
                        children: [
                          // Age (rectangle plus petit)
                          SizedBox(
                            width: screenWidth * 0.35, // 35% de la largeur pour "Age"
                            child: _buildDropdownField(
                              label: 'Age',
                              value: _selectedAge,
                              items: ['18-24', '25+', '30+', '40+'],
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedAge = newValue ?? '25+';
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Country of Residence (prend le reste de l'espace)
                          Expanded(
                            child: _buildCountryDropdownField(
                              label: 'Country of Residence',
                              value: _selectedCountry,
                              items: countries,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCountry = newValue ?? 'Morocco';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30), // Plus d'espace entre les cases
                      // Discount Codes
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DISCOUNT CODES',
                            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                                // Icône de ticket à gauche
                                Icon(
                                  Icons.local_offer,
                                  color: AppConstants.primaryColor, // Vert foncé
                                  size: 24,
                                ),
                                // Pour importer une icône personnalisée, remplacez l'Icon ci-dessus par :
                                // Image.asset('assets/icons/ticket_icon.png', width: 24, height: 24),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: _discountCodeController,
                                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'YOURCODE',
                                      hintStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                                        color: Colors.grey.shade400, // Gris clair pour le placeholder
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                // Icône de crayon à droite dans un rectangle
                                Container(
                                  padding: const EdgeInsets.all(4), // Padding à l'intérieur du rectangle
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF878787), // Couleur HEX #878787
                                    borderRadius: BorderRadius.circular(4), // Coins arrondis pour le rectangle
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white, // Icône blanche pour contraster avec le fond gris
                                    size: 16, // Taille plus petite pour l'icône dans le rectangle
                                  ),
                                  // Pour importer une icône personnalisée, remplacez l'Icon ci-dessus par :
                                  // Image.asset('assets/icons/edit_icon.png', width: 16, height: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30), // Plus d'espace entre les cases
                      // Bouton "Find Vehicles"
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Naviguer vers SearchResultScreen avec les données
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchResultScreen(
                                  pickupLocation: _pickupLocationController.text,
                                  pickupDate: _pickupDateController.text.split('|')[0].trim(),
                                  dropoffDate: _dropoffDateController.text.split('|')[0].trim(),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'FIND VEHICLES',
                            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0), // "Search" est actif
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required TextEditingController controller,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              Icon(icon, color: Colors.black54),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCountryDropdownField({
    required String label,
    required String value,
    required List<Map<String, String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  items: items.map((Map<String, String> item) {
                    return DropdownMenuItem<String>(
                      value: item['name'],
                      child: Row(
                        children: [
                          Text(
                            item['flag']!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            item['name']!,
                            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}