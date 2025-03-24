import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pour parser les dates
import 'package:vahanar_front/constants.dart'; // Import des constantes
import 'package:vahanar_front/theme.dart'; // Import du thème
import 'package:vahanar_front/widgets/bottom_nav_bar.dart'; // Barre de navigation
import 'filter_screen.dart'; // Import de la page FilterScreen
import 'product_page_screen.dart'; // Import de ProductPageScreen

// Définition de la classe Vehicle pour représenter un véhicule
class Vehicle {
  final String category;
  final String name;
  final String imageUrl;
  final int doors;
  final int passengers;
  final int luggage;
  final String transmission;
  final String pricePerDay;
  final String estimatedTotal;
  final List<String> features;
  final String minDriverAge;

  Vehicle({
    required this.category,
    required this.name,
    required this.imageUrl,
    required this.doors,
    required this.passengers,
    required this.luggage,
    required this.transmission,
    required this.pricePerDay,
    required this.estimatedTotal,
    required this.features,
    required this.minDriverAge,
  });
}

// Widget principal pour l'écran de résultats de recherche
class SearchResultScreen extends StatefulWidget {
  final String pickupLocation;
  final String pickupDate;
  final String dropoffDate;

  const SearchResultScreen({
    super.key,
    required this.pickupLocation,
    required this.pickupDate,
    required this.dropoffDate,
  });

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> with SingleTickerProviderStateMixin {
  // Liste des 100 véhicules (inchangée)
  List<Vehicle> allVehicles = [
    Vehicle(
      category: 'SUV',
      name: 'Toyota RAV4',
      imageUrl: 'assets/images/toyota_rav4.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1800/day',
      estimatedTotal: 'MAD 3600 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS', 'Bluetooth'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Jeep Wrangler',
      imageUrl: 'assets/images/jeep_wrangler.png',
      doors: 4,
      passengers: 4,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1900/day',
      estimatedTotal: 'MAD 3800 est. total',
      features: ['Manual transmission', 'Sunroof'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Ford Escape',
      imageUrl: 'assets/images/ford_escape.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1700/day',
      estimatedTotal: 'MAD 3400 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Honda CR-V',
      imageUrl: 'assets/images/honda_crv.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1850/day',
      estimatedTotal: 'MAD 3700 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Subaru Forester',
      imageUrl: 'assets/images/subaru_forester.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1750/day',
      estimatedTotal: 'MAD 3500 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Sunroof'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Chevrolet Traverse',
      imageUrl: 'assets/images/chevrolet_traverse.png',
      doors: 4,
      passengers: 7,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2100/day',
      estimatedTotal: 'MAD 4200 est. total',
      features: ['Automatic transmission', 'GPS', 'Bluetooth'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Kia Sorento',
      imageUrl: 'assets/images/kia_sorento.png',
      doors: 4,
      passengers: 6,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1950/day',
      estimatedTotal: 'MAD 3900 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Heated seats'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Hyundai Tucson',
      imageUrl: 'assets/images/hyundai_tucson.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1650/day',
      estimatedTotal: 'MAD 3300 est. total',
      features: ['Automatic transmission', 'Bluetooth', 'Sunroof'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Mazda CX-5',
      imageUrl: 'assets/images/mazda_cx5.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1800/day',
      estimatedTotal: 'MAD 3600 est. total',
      features: ['Automatic transmission', 'GPS', 'Air conditioning'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Volkswagen Tiguan',
      imageUrl: 'assets/images/vw_tiguan.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1900/day',
      estimatedTotal: 'MAD 3800 est. total',
      features: ['Automatic transmission', 'Heated seats', 'Bluetooth'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Nissan X-Trail',
      imageUrl: 'assets/images/nissan_xtrail.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1750/day',
      estimatedTotal: 'MAD 3500 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Audi Q5',
      imageUrl: 'assets/images/audi_q5.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2500/day',
      estimatedTotal: 'MAD 5000 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'SUV',
      name: 'BMW X3',
      imageUrl: 'assets/images/bmw_x3.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2600/day',
      estimatedTotal: 'MAD 5200 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Mercedes GLC',
      imageUrl: 'assets/images/mercedes_glc.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2700/day',
      estimatedTotal: 'MAD 5400 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Lexus RX',
      imageUrl: 'assets/images/lexus_rx.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2800/day',
      estimatedTotal: 'MAD 5600 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Porsche Cayenne',
      imageUrl: 'assets/images/porsche_cayenne.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 3200/day',
      estimatedTotal: 'MAD 6400 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Land Rover Discovery',
      imageUrl: 'assets/images/landrover_discovery.png',
      doors: 4,
      passengers: 7,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 3000/day',
      estimatedTotal: 'MAD 6000 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Mitsubishi Outlander',
      imageUrl: 'assets/images/mitsubishi_outlander.png',
      doors: 4,
      passengers: 7,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2000/day',
      estimatedTotal: 'MAD 4000 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'SUV',
      name: 'Dodge Durango',
      imageUrl: 'assets/images/dodge_durango.png',
      doors: 4,
      passengers: 7,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2200/day',
      estimatedTotal: 'MAD 4400 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'SUV',
      name: 'GMC Acadia',
      imageUrl: 'assets/images/gmc_acadia.png',
      doors: 4,
      passengers: 6,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2100/day',
      estimatedTotal: 'MAD 4200 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Volkswagen Golf',
      imageUrl: 'assets/images/vw_golf.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1200/day',
      estimatedTotal: 'MAD 2400 est. total',
      features: ['Manual transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '21',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Honda Civic Hatchback',
      imageUrl: 'assets/images/honda_civic_hatchback.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1300/day',
      estimatedTotal: 'MAD 2600 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Ford Focus',
      imageUrl: 'assets/images/ford_focus.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1100/day',
      estimatedTotal: 'MAD 2200 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '21',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Toyota Corolla Hatchback',
      imageUrl: 'assets/images/toyota_corolla_hatchback.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1250/day',
      estimatedTotal: 'MAD 2500 est. total',
      features: ['Automatic transmission', 'Bluetooth', 'Air conditioning'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Hyundai i30',
      imageUrl: 'assets/images/hyundai_i30.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1150/day',
      estimatedTotal: 'MAD 2300 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '21',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Kia Rio',
      imageUrl: 'assets/images/kia_rio.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1200/day',
      estimatedTotal: 'MAD 2400 est. total',
      features: ['Automatic transmission', 'Bluetooth'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Mazda 3 Hatchback',
      imageUrl: 'assets/images/mazda3_hatchback.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1350/day',
      estimatedTotal: 'MAD 2700 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Peugeot 208',
      imageUrl: 'assets/images/peugeot_208.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1100/day',
      estimatedTotal: 'MAD 2200 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '21',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Renault Clio',
      imageUrl: 'assets/images/renault_clio.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1050/day',
      estimatedTotal: 'MAD 2100 est. total',
      features: ['Manual transmission', 'Bluetooth'],
      minDriverAge: '21',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Seat Ibiza',
      imageUrl: 'assets/images/seat_ibiza.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1000/day',
      estimatedTotal: 'MAD 2000 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '21',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Fiat 500',
      imageUrl: 'assets/images/fiat_500.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1100/day',
      estimatedTotal: 'MAD 2200 est. total',
      features: ['Automatic transmission', 'Bluetooth'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Mini Cooper',
      imageUrl: 'assets/images/mini_cooper.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1500/day',
      estimatedTotal: 'MAD 3000 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Citroen C3',
      imageUrl: 'assets/images/citroen_c3.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1050/day',
      estimatedTotal: 'MAD 2100 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '21',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Opel Corsa',
      imageUrl: 'assets/images/opel_corsa.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1000/day',
      estimatedTotal: 'MAD 2000 est. total',
      features: ['Manual transmission', 'Bluetooth'],
      minDriverAge: '21',
    ),
    Vehicle(
      category: 'Hatchback',
      name: 'Skoda Fabia',
      imageUrl: 'assets/images/skoda_fabia.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1000/day',
      estimatedTotal: 'MAD 2000 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '21',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Nissan Rogue',
      imageUrl: 'assets/images/nissan_rogue.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1600/day',
      estimatedTotal: 'MAD 3200 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Toyota C-HR',
      imageUrl: 'assets/images/toyota_chr.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1500/day',
      estimatedTotal: 'MAD 3000 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Honda HR-V',
      imageUrl: 'assets/images/honda_hrv.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1450/day',
      estimatedTotal: 'MAD 2900 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Kia Sportage',
      imageUrl: 'assets/images/kia_sportage.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1650/day',
      estimatedTotal: 'MAD 3300 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Hyundai Kona',
      imageUrl: 'assets/images/hyundai_kona.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1400/day',
      estimatedTotal: 'MAD 2800 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Mazda CX-30',
      imageUrl: 'assets/images/mazda_cx30.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1550/day',
      estimatedTotal: 'MAD 3100 est. total',
      features: ['Automatic transmission', 'GPS', 'Air conditioning'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Subaru Crosstrek',
      imageUrl: 'assets/images/subaru_crosstrek.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Manual',
      pricePerDay: 'MAD 1350/day',
      estimatedTotal: 'MAD 2700 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Volkswagen Taos',
      imageUrl: 'assets/images/vw_taos.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1500/day',
      estimatedTotal: 'MAD 3000 est. total',
      features: ['Automatic transmission', 'Bluetooth', 'Air conditioning'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Chevrolet Equinox',
      imageUrl: 'assets/images/chevrolet_equinox.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1600/day',
      estimatedTotal: 'MAD 3200 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Ford Bronco Sport',
      imageUrl: 'assets/images/ford_bronco_sport.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1700/day',
      estimatedTotal: 'MAD 3400 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Jeep Compass',
      imageUrl: 'assets/images/jeep_compass.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1550/day',
      estimatedTotal: 'MAD 3100 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Audi Q3',
      imageUrl: 'assets/images/audi_q3.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2300/day',
      estimatedTotal: 'MAD 4600 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'BMW X1',
      imageUrl: 'assets/images/bmw_x1.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2400/day',
      estimatedTotal: 'MAD 4800 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Mercedes GLA',
      imageUrl: 'assets/images/mercedes_gla.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2500/day',
      estimatedTotal: 'MAD 5000 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Crossover',
      name: 'Lexus NX',
      imageUrl: 'assets/images/lexus_nx.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2600/day',
      estimatedTotal: 'MAD 5200 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Honda Accord',
      imageUrl: 'assets/images/honda_accord.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1400/day',
      estimatedTotal: 'MAD 2800 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Heated seats'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Toyota Camry',
      imageUrl: 'assets/images/toyota_camry.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1450/day',
      estimatedTotal: 'MAD 2900 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Nissan Altima',
      imageUrl: 'assets/images/nissan_altima.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1350/day',
      estimatedTotal: 'MAD 2700 est. total',
      features: ['Automatic transmission', 'GPS', 'Air conditioning'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Hyundai Sonata',
      imageUrl: 'assets/images/hyundai_sonata.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1400/day',
      estimatedTotal: 'MAD 2800 est. total',
      features: ['Automatic transmission', 'Bluetooth', 'Heated seats'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Kia Optima',
      imageUrl: 'assets/images/kia_optima.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1350/day',
      estimatedTotal: 'MAD 2700 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Mazda 6',
      imageUrl: 'assets/images/mazda6.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1500/day',
      estimatedTotal: 'MAD 3000 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Volkswagen Passat',
      imageUrl: 'assets/images/vw_passat.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1550/day',
      estimatedTotal: 'MAD 3100 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Ford Fusion',
      imageUrl: 'assets/images/ford_fusion.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1400/day',
      estimatedTotal: 'MAD 2800 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Chevrolet Malibu',
      imageUrl: 'assets/images/chevrolet_malibu.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1350/day',
      estimatedTotal: 'MAD 2700 est. total',
      features: ['Automatic transmission', 'GPS', 'Air conditioning'],
      minDriverAge: '22',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Subaru Legacy',
      imageUrl: 'assets/images/subaru_legacy.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 1450/day',
      estimatedTotal: 'MAD 2900 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '23',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Audi A4',
      imageUrl: 'assets/images/audi_a4.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2200/day',
      estimatedTotal: 'MAD 4400 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'BMW 3 Series',
      imageUrl: 'assets/images/bmw_3series.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2300/day',
      estimatedTotal: 'MAD 4600 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Mercedes C-Class',
      imageUrl: 'assets/images/mercedes_cclass.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2400/day',
      estimatedTotal: 'MAD 4800 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Lexus ES',
      imageUrl: 'assets/images/lexus_es.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2500/day',
      estimatedTotal: 'MAD 5000 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Porsche Panamera',
      imageUrl: 'assets/images/porsche_panamera.png',
      doors: 4,
      passengers: 4,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 3200/day',
      estimatedTotal: 'MAD 6400 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Tesla Model 3',
      imageUrl: 'assets/images/tesla_model3.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2800/day',
      estimatedTotal: 'MAD 5600 est. total',
      features: ['Automatic transmission', 'GPS', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Jaguar XE',
      imageUrl: 'assets/images/jaguar_xe.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2600/day',
      estimatedTotal: 'MAD 5200 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Alfa Romeo Giulia',
      imageUrl: 'assets/images/alfa_romeo_giulia.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2700/day',
      estimatedTotal: 'MAD 5400 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Volvo S60',
      imageUrl: 'assets/images/volvo_s60.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2300/day',
      estimatedTotal: 'MAD 4600 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Sedan',
      name: 'Infiniti Q50',
      imageUrl: 'assets/images/infiniti_q50.png',
      doors: 4,
      passengers: 5,
      luggage: 2,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2200/day',
      estimatedTotal: 'MAD 4400 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'BMW 2 Series',
      imageUrl: 'assets/images/bmw_2series.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Manual',
      pricePerDay: 'MAD 2000/day',
      estimatedTotal: 'MAD 4000 est. total',
      features: ['Manual transmission', 'Sunroof', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'Audi A5',
      imageUrl: 'assets/images/audi_a5.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2400/day',
      estimatedTotal: 'MAD 4800 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'Mercedes C-Class Coupe',
      imageUrl: 'assets/images/mercedes_cclass_coupe.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2500/day',
      estimatedTotal: 'MAD 5000 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'Porsche 911',
      imageUrl: 'assets/images/porsche_911.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Automatic',
      pricePerDay: 'MAD 3500/day',
      estimatedTotal: 'MAD 7000 est. total',
      features: ['Automatic transmission', 'GPS', 'Sunroof', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'Chevrolet Camaro',
      imageUrl: 'assets/images/chevrolet_camaro.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Manual',
      pricePerDay: 'MAD 2200/day',
      estimatedTotal: 'MAD 4400 est. total',
      features: ['Manual transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'Ford Mustang',
      imageUrl: 'assets/images/ford_mustang.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Manual',
      pricePerDay: 'MAD 2300/day',
      estimatedTotal: 'MAD 4600 est. total',
      features: ['Manual transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'Dodge Challenger',
      imageUrl: 'assets/images/dodge_challenger.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Manual',
      pricePerDay: 'MAD 2400/day',
      estimatedTotal: 'MAD 4800 est. total',
      features: ['Manual transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'Toyota Supra',
      imageUrl: 'assets/images/toyota_supra.png',
      doors: 2,
      passengers: 2,
      luggage: 1,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2600/day',
      estimatedTotal: 'MAD 5200 est. total',
      features: ['Automatic transmission', 'GPS', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'Nissan 370Z',
      imageUrl: 'assets/images/nissan_370z.png',
      doors: 2,
      passengers: 2,
      luggage: 1,
      transmission: 'Manual',
      pricePerDay: 'MAD 2100/day',
      estimatedTotal: 'MAD 4200 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Coupe',
      name: 'Lexus RC',
      imageUrl: 'assets/images/lexus_rc.png',
      doors: 2,
      passengers: 4,
      luggage: 1,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2500/day',
      estimatedTotal: 'MAD 5000 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Chrysler Pacifica',
      imageUrl: 'assets/images/chrysler_pacifica.png',
      doors: 4,
      passengers: 7,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2200/day',
      estimatedTotal: 'MAD 4400 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Honda Odyssey',
      imageUrl: 'assets/images/honda_odyssey.png',
      doors: 4,
      passengers: 8,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2300/day',
      estimatedTotal: 'MAD 4600 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Toyota Sienna',
      imageUrl: 'assets/images/toyota_sienna.png',
      doors: 4,
      passengers: 8,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2250/day',
      estimatedTotal: 'MAD 4500 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Kia Carnival',
      imageUrl: 'assets/images/kia_carnival.png',
      doors: 4,
      passengers: 8,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2200/day',
      estimatedTotal: 'MAD 4400 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Dodge Grand Caravan',
      imageUrl: 'assets/images/dodge_grand_caravan.png',
      doors: 4,
      passengers: 7,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2100/day',
      estimatedTotal: 'MAD 4200 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Ford Transit Connect',
      imageUrl: 'assets/images/ford_transit_connect.png',
      doors: 4,
      passengers: 7,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2000/day',
      estimatedTotal: 'MAD 4000 est. total',
      features: ['Automatic transmission', 'Air conditioning'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Mercedes Metris',
      imageUrl: 'assets/images/mercedes_metris.png',
      doors: 4,
      passengers: 8,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2500/day',
      estimatedTotal: 'MAD 5000 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Volkswagen Transporter',
      imageUrl: 'assets/images/vw_transporter.png',
      doors: 4,
      passengers: 7,
      luggage: 4,
      transmission: 'Manual',
      pricePerDay: 'MAD 1900/day',
      estimatedTotal: 'MAD 3800 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Nissan Quest',
      imageUrl: 'assets/images/nissan_quest.png',
      doors: 4,
      passengers: 7,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2100/day',
      estimatedTotal: 'MAD 4200 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Minivan',
      name: 'Hyundai Staria',
      imageUrl: 'assets/images/hyundai_staria.png',
      doors: 4,
      passengers: 8,
      luggage: 4,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2300/day',
      estimatedTotal: 'MAD 4600 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '24',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'Ford F-150',
      imageUrl: 'assets/images/ford_f150.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2500/day',
      estimatedTotal: 'MAD 5000 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'Chevrolet Silverado',
      imageUrl: 'assets/images/chevrolet_silverado.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2600/day',
      estimatedTotal: 'MAD 5200 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'Ram 1500',
      imageUrl: 'assets/images/ram_1500.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2700/day',
      estimatedTotal: 'MAD 5400 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'Toyota Tacoma',
      imageUrl: 'assets/images/toyota_tacoma.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2400/day',
      estimatedTotal: 'MAD 4800 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'Nissan Titan',
      imageUrl: 'assets/images/nissan_titan.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2500/day',
      estimatedTotal: 'MAD 5000 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'GMC Sierra',
      imageUrl: 'assets/images/gmc_sierra.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2600/day',
      estimatedTotal: 'MAD 5200 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'Jeep Gladiator',
      imageUrl: 'assets/images/jeep_gladiator.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Manual',
      pricePerDay: 'MAD 2300/day',
      estimatedTotal: 'MAD 4600 est. total',
      features: ['Manual transmission', 'Air conditioning'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'Ford Ranger',
      imageUrl: 'assets/images/ford_ranger.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2200/day',
      estimatedTotal: 'MAD 4400 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'Bluetooth'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'Chevrolet Colorado',
      imageUrl: 'assets/images/chevrolet_colorado.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2100/day',
      estimatedTotal: 'MAD 4200 est. total',
      features: ['Automatic transmission', 'Air conditioning', 'GPS'],
      minDriverAge: '25+',
    ),
    Vehicle(
      category: 'Pickup',
      name: 'Toyota Tundra',
      imageUrl: 'assets/images/toyota_tundra.png',
      doors: 4,
      passengers: 5,
      luggage: 3,
      transmission: 'Automatic',
      pricePerDay: 'MAD 2700/day',
      estimatedTotal: 'MAD 5400 est. total',
      features: ['Automatic transmission', 'GPS', 'Heated seats'],
      minDriverAge: '25+',
    ),
  ];

  // Liste des véhicules filtrés
  List<Vehicle> filteredVehicles = [];

  // Filtres par défaut
  String selectedSortBy = 'Featured';
  String selectedVehicleType = 'SUV';
  String selectedFeature = 'Automatic transmission';
  int selectedSeats = 4;
  String selectedDriverAge = '24';

  // État pour gérer l'affichage de la liste de choix
  bool showSortOptions = false;

  // Contrôleur pour l'animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    filteredVehicles = List.from(allVehicles);
    applyFilters();

    // Initialisation de l'animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, -0.2), end: const Offset(0, 0)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Fonction pour calculer la durée entre deux dates
  int calculateDuration(String pickupDate, String dropoffDate) {
    try {
      final DateFormat formatter = DateFormat('MMM dd');
      final DateTime pickup = formatter.parse('$pickupDate ${DateTime.now().year}');
      final DateTime dropoff = formatter.parse('$dropoffDate ${DateTime.now().year}');
      return dropoff.difference(pickup).inDays;
    } catch (e) {
      return 2; // Valeur par défaut si le parsing échoue
    }
  }

  // Fonction pour appliquer les filtres et trier les véhicules
  void applyFilters() {
    setState(() {
      filteredVehicles = allVehicles.where((vehicle) {
        // Filtrer par type de véhicule
        if (selectedVehicleType.isNotEmpty && vehicle.category != selectedVehicleType) {
          return false;
        }

        // Filtrer par feature
        if (selectedFeature.isNotEmpty && !vehicle.features.contains(selectedFeature)) {
          return false;
        }

        // Filtrer par nombre minimum de sièges
        if (vehicle.passengers < selectedSeats) {
          return false;
        }

        // Filtrer par âge minimum du conducteur
        if (selectedDriverAge != '25+') {
          int selectedAge = int.parse(selectedDriverAge);
          if (vehicle.minDriverAge == '25+') {
            return false;
          }
          int vehicleMinAge = int.parse(vehicle.minDriverAge);
          if (vehicleMinAge > selectedAge) {
            return false;
          }
        }

        return true;
      }).toList();

      // Trier en fonction de "Sort By"
      if (selectedSortBy == 'Lowest price') {
        filteredVehicles.sort((a, b) {
          double priceA = double.parse(a.pricePerDay.replaceAll('MAD ', '').replaceAll('/day', ''));
          double priceB = double.parse(b.pricePerDay.replaceAll('MAD ', '').replaceAll('/day', ''));
          return priceA.compareTo(priceB);
        });
      } else if (selectedSortBy == 'Highest price') {
        filteredVehicles.sort((a, b) {
          double priceA = double.parse(a.pricePerDay.replaceAll('MAD ', '').replaceAll('/day', ''));
          double priceB = double.parse(b.pricePerDay.replaceAll('MAD ', '').replaceAll('/day', ''));
          return priceB.compareTo(priceA);
        });
      } else if (selectedSortBy == 'A to Z') {
        filteredVehicles.sort((a, b) => a.name.compareTo(b.name));
      } else if (selectedSortBy == 'Z to A') {
        filteredVehicles.sort((a, b) => b.name.compareTo(a.name));
      }
      // Si "Featured", on garde l'ordre par défaut
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int durationDays = calculateDuration(widget.pickupDate, widget.dropoffDate);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // En-tête avec le rectangle bleu
            _buildHeader(screenWidth, durationDays),
            // Contenu principal (liste des véhicules et filtres)
            _buildMainContent(screenWidth),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0), // "Search" est actif
    );
  }

  // Construit l'en-tête avec le rectangle bleu
  Widget _buildHeader(double screenWidth, int durationDays) {
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFF004852),
        borderRadius: BorderRadius.zero, // Coins arrondis supprimés
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icône de retour
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Retour à SearchScreen
            },
          ),
          // Titre "SELECT YOUR VEHICLE"
          Text(
            'SELECT YOUR VEHICLE',
            style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Rectangle blanc pour les informations de recherche
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pickupLocation,
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tue ${widget.pickupDate} – Thu ${widget.dropoffDate}',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '|   ',
                          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: 'DAY ',
                          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: '$durationDays',
                          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Construit le contenu principal (boutons de filtre et liste des véhicules)
  Widget _buildMainContent(double screenWidth) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Boutons "Filter & Sort" et "Automatic transmission"
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Bouton "Filter & Sort"
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreen(
                          initialSortBy: selectedSortBy,
                          initialVehicleType: selectedVehicleType,
                          initialFeature: selectedFeature,
                          initialSeats: selectedSeats.toString(),
                          initialDriverAge: selectedDriverAge,
                        ),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        selectedSortBy = result['sortBy'] ?? selectedSortBy;
                        selectedVehicleType = result['vehicleType'] ?? selectedVehicleType;
                        selectedFeature = result['feature'] ?? selectedFeature;
                        selectedSeats = int.parse(result['seats'] ?? selectedSeats.toString());
                        selectedDriverAge = result['driverAge'] ?? selectedDriverAge;
                      });
                      applyFilters();
                    }
                  },
                  icon: const Icon(Icons.filter_list, size: 20),
                  label: Text(
                    'Filter & Sort',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Espacement entre les boutons
                // Bouton "Automatic transmission"
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      if (showSortOptions) {
                        showSortOptions = false;
                        _animationController.reverse();
                      } else {
                        selectedFeature = 'Automatic transmission';
                        showSortOptions = true;
                        _animationController.forward();
                      }
                    });
                    applyFilters();
                  },
                  icon: const Icon(Icons.settings, size: 20),
                  label: Text(
                    'Automatic transmission',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedFeature == 'Automatic transmission'
                        ? Colors.grey.shade300
                        : Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            // Liste de choix pour le tri (affichée si showSortOptions est vrai)
            if (showSortOptions) ...[
              const SizedBox(height: 8),
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA), // Fond blanc cassé élégant
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildSortOption(
                          'Prix : Haut vers Bas',
                          'Highest price',
                          const Icon(Icons.arrow_downward, color: Colors.blueAccent),
                        ),
                        _buildDivider(),
                        _buildSortOption(
                          'Prix : Bas vers Haut',
                          'Lowest price',
                          const Icon(Icons.arrow_upward, color: Colors.green),
                        ),
                        _buildDivider(),
                        _buildSortOption(
                          'Nom : A vers Z',
                          'A to Z',
                          const Icon(Icons.sort_by_alpha, color: Colors.purple),
                        ),
                        _buildDivider(),
                        _buildSortOption(
                          'Nom : Z vers A',
                          'Z to A',
                          const Icon(Icons.sort_by_alpha, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Liste des véhicules
            Expanded(
              child: ListView.builder(
                itemCount: filteredVehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = filteredVehicles[index];
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navigation vers ProductPageScreen avec les détails du véhicule
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPageScreen(
                              pickupLocation: widget.pickupLocation,
                              pickupDate: widget.pickupDate,
                              dropoffDate: widget.dropoffDate,
                              category: vehicle.category,
                              name: vehicle.name,
                              imageUrl: vehicle.imageUrl,
                              doors: vehicle.doors,
                              passengers: vehicle.passengers,
                              luggage: vehicle.luggage,
                              transmission: vehicle.transmission,
                              pricePerDay: vehicle.pricePerDay,
                              estimatedTotal: vehicle.estimatedTotal,
                            ),
                          ),
                        );
                      },
                      child: _buildVehicleCard(
                        category: vehicle.category,
                        name: vehicle.name,
                        imageUrl: vehicle.imageUrl,
                        doors: vehicle.doors,
                        passengers: vehicle.passengers,
                        luggage: vehicle.luggage,
                        transmission: vehicle.transmission,
                        pricePerDay: vehicle.pricePerDay,
                        estimatedTotal: vehicle.estimatedTotal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construit un séparateur entre les options
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Divider(
        color: Colors.grey.shade300,
        thickness: 1,
        height: 1,
      ),
    );
  }

  // Construit une option de tri dans la liste
  Widget _buildSortOption(String displayText, String sortValue, Icon icon) {
    bool isSelected = selectedSortBy == sortValue;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSortBy = sortValue;
          showSortOptions = false;
          _animationController.reverse();
        });
        applyFilters();
      },
      onDoubleTap: () {
        // Désélectionner uniquement si l'option est déjà sélectionnée
        if (isSelected) {
          setState(() {
            selectedSortBy = 'Featured'; // Revenir à la valeur par défaut
            showSortOptions = false;
            _animationController.reverse();
          });
          applyFilters();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Text(
                  displayText,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: isSelected ? Colors.blue : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            if (isSelected)
              AnimatedScale(
                scale: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Construit une carte pour afficher les détails d'un véhicule
  Widget _buildVehicleCard({
    required String category,
    required String name,
    required String imageUrl,
    required int doors,
    required int passengers,
    required int luggage,
    required String transmission,
    required String pricePerDay,
    required String estimatedTotal,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Titre et nom du véhicule
          Text(
            category,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Image du véhicule
          Image.asset(
            imageUrl,
            width: 250,
            height: 150,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.directions_car, size: 120, color: Colors.black54);
            },
          ),
          const SizedBox(height: 12),
          // Icônes pour les caractéristiques du véhicule
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_gas_station, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(
                '$doors',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.person, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(
                '$passengers',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.luggage, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(
                '$luggage',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.directions_car, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(
                transmission,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Ligne séparatrice
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
          const SizedBox(height: 12),
          // Prix du véhicule
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Price',
                style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    pricePerDay,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    estimatedTotal,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}