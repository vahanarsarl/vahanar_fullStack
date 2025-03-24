import 'package:flutter/material.dart';
import 'package:vahanar_front/animations/button_animations.dart';
import 'package:vahanar_front/constants.dart'; // Import des constantes
import 'package:vahanar_front/theme.dart'; // Import du thème

class FilterScreen extends StatefulWidget {
  final String initialSortBy;
  final String initialVehicleType;
  final String initialFeature;
  final String initialSeats;
  final String initialDriverAge;

  const FilterScreen({
    super.key,
    required this.initialSortBy,
    required this.initialVehicleType,
    required this.initialFeature,
    required this.initialSeats,
    required this.initialDriverAge,
  });

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Variables pour stocker les sélections, initialisées avec les valeurs passées
  late String selectedSortBy;
  late String selectedVehicleType;
  late String selectedFeature;
  late String selectedSeats;
  late String selectedDriverAge;

  // Listes pour "Vehicle type" et "Features"
  final List<String> vehicleTypes = [
    'SUV',
    'Hatchback',
    'Crossover',
    'Sedan',
    'Coupe',
    'Minivan',
    'Pickup',
  ];

  final List<Map<String, dynamic>> features = [
    {'label': 'Automatic transmission', 'icon': Icons.directions_car},
    {'label': 'Manual transmission', 'icon': Icons.directions_car},
    {'label': 'Air conditioning', 'icon': Icons.ac_unit},
    {'label': 'GPS', 'icon': Icons.gps_fixed},
    {'label': 'Bluetooth', 'icon': Icons.bluetooth},
    {'label': 'Sunroof', 'icon': Icons.wb_sunny},
    {'label': 'Heated seats', 'icon': Icons.event_seat},
  ];

  @override
  void initState() {
    super.initState();
    // Initialiser les sélections avec les valeurs passées via le constructeur
    selectedSortBy = widget.initialSortBy;
    selectedVehicleType = widget.initialVehicleType;
    selectedFeature = widget.initialFeature;
    selectedSeats = widget.initialSeats;
    selectedDriverAge = widget.initialDriverAge;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // En-tête
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context); // Retour à SearchResultScreen
                    },
                  ),
                  Text(
                    'FILTRE',
                    style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48), // Espace pour équilibrer avec l'icône
                ],
              ),
            ),
            // Contenu principal
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section "Sort By"
                    Text(
                      'Sort By',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildFilterButton('Featured', selectedSortBy, (value) {
                          setState(() {
                            selectedSortBy = value;
                          });
                        }),
                        const SizedBox(width: 8),
                        _buildFilterButton('Lowest price', selectedSortBy, (value) {
                          setState(() {
                            selectedSortBy = value;
                          });
                        }),
                        const SizedBox(width: 8),
                        _buildFilterButton('Highest price', selectedSortBy, (value) {
                          setState(() {
                            selectedSortBy = value;
                          });
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Section "Vehicle type" avec défilement horizontal
                    Text(
                      'Vehicle type',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: vehicleTypes.map((type) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _buildFilterButton(type, selectedVehicleType, (value) {
                              setState(() {
                                selectedVehicleType = value;
                              });
                            }),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Section "Features" avec défilement horizontal
                    Text(
                      'Features',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: features.map((feature) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _buildFilterButton(
                              feature['label'],
                              selectedFeature,
                              (value) {
                                setState(() {
                                  selectedFeature = value;
                                });
                              },
                              icon: feature['icon'],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Section "Minimum number of seats"
                    Text(
                      'Minimum number of seats',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildFilterButton('4', selectedSeats, (value) {
                          setState(() {
                            selectedSeats = value;
                          });
                        }),
                        const SizedBox(width: 8),
                        _buildFilterButton('5', selectedSeats, (value) {
                          setState(() {
                            selectedSeats = value;
                          });
                        }),
                        const SizedBox(width: 8),
                        _buildFilterButton('9', selectedSeats, (value) {
                          setState(() {
                            selectedSeats = value;
                          });
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Section "Minimum Age of primary driver"
                    Text(
                      'Minimum Age of primary driver',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFilterButton('21', selectedDriverAge, (value) {
                          setState(() {
                            selectedDriverAge = value;
                          });
                        }),
                        _buildFilterButton('22', selectedDriverAge, (value) {
                          setState(() {
                            selectedDriverAge = value;
                          });
                        }),
                        _buildFilterButton('23', selectedDriverAge, (value) {
                          setState(() {
                            selectedDriverAge = value;
                          });
                        }),
                        _buildFilterButton('24', selectedDriverAge, (value) {
                          setState(() {
                            selectedDriverAge = value;
                          });
                        }),
                        _buildFilterButton('25+', selectedDriverAge, (value) {
                          setState(() {
                            selectedDriverAge = value;
                          });
                        }),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Bouton "Show offers"
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Renvoyer les sélections à SearchResultScreen
                          Navigator.pop(context, {
                            'sortBy': selectedSortBy,
                            'vehicleType': selectedVehicleType,
                            'feature': selectedFeature,
                            'seats': selectedSeats,
                            'driverAge': selectedDriverAge,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF004852),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Show offers', // Le nombre de résultats sera calculé dans SearchResultScreen
                          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, String selectedValue, Function(String) onTap, {IconData? icon}) {
    bool isSelected = label == selectedValue;
    return ButtonAnimation(
      isSelected: isSelected,
      onTap: () => onTap(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}