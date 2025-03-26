import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pour parser les dates
import 'package:vahanar_front/constants.dart'; // Import des constantes
import 'package:vahanar_front/theme.dart'; // Import du thème
import 'package:vahanar_front/screens/home/conditions_popup.dart'; // Importer le widget ConditionsPopup

// Définition de la classe Vehicle pour représenter une voiture
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
  final String subtitle; // Sous-titre unique
  final String description; // Description (vide pour que tu puisses la remplir)

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
    required this.subtitle,
    required this.description,
  });
}

class ProductPageScreen extends StatefulWidget {
  final String pickupLocation;
  final String pickupDate;
  final String dropoffDate;
  final String category;
  final String name;
  final String imageUrl;
  final int doors;
  final int passengers;
  final int luggage;
  final String transmission;
  final String pricePerDay;
  final String estimatedTotal;

  const ProductPageScreen({
    super.key,
    required this.pickupLocation,
    required this.pickupDate,
    required this.dropoffDate,
    required this.category,
    required this.name,
    required this.imageUrl,
    required this.doors,
    required this.passengers,
    required this.luggage,
    required this.transmission,
    required this.pricePerDay,
    required this.estimatedTotal,
  });

  @override
  _ProductPageScreenState createState() => _ProductPageScreenState();
}

class _ProductPageScreenState extends State<ProductPageScreen> {
  bool _isExpanded = false; // État pour gérer l'affichage de la description complète

  // Liste statique des 100 voitures avec sous-titres et descriptions vides
  static final List<Vehicle> allVehicles = [
    // SUV (20 voitures)
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
      subtitle: 'compact family SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'full-size adventure SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'mid-size practical SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'versatile family SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'rugged outdoor SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'spacious family SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'modern mid-size SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'stylish compact SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'sporty mid-size SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'elegant family SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'versatile adventure SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'luxury mid-size SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'premium sporty SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'elegant luxury SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'refined mid-size SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'high-performance SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'luxury off-road SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'spacious mid-size SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'powerful family SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'versatile mid-size SUV',
      description: '', // Case vide pour ton texte
    ),
    // Hatchback (15 voitures)
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
      subtitle: 'compact city hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'sporty urban hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'economical hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'reliable city hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'modern compact hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'stylish urban hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'premium compact hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'chic city hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'versatile urban hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'dynamic compact hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'retro city hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'iconic sporty hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'trendy urban hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'practical city hatchback',
      description: '', // Case vide pour ton texte
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
      subtitle: 'affordable compact hatchback',
      description: '', // Case vide pour ton texte
    ),
    // Crossover (15 voitures)
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
      subtitle: 'mid-size crossover SUV',
      description: '', // Case vide pour ton texte
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
      subtitle: 'stylish compact crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'versatile urban crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'modern mid-size crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'compact trendy crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'sporty compact crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'rugged compact crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'elegant urban crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'practical mid-size crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'adventurous compact crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'off-road capable crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'luxury compact crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'premium sporty crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'elegant luxury crossover',
      description: '', // Case vide pour ton texte
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
      subtitle: 'refined compact crossover',
      description: '', // Case vide pour ton texte
    ),
    // Sedan (20 voitures)
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
      subtitle: 'mid-size family sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'reliable family sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'comfortable mid-size sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'modern family sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'stylish mid-size sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'sporty family sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'elegant mid-size sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'practical family sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'comfortable family sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'versatile mid-size sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'luxury executive sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'premium sporty sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'elegant luxury sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'refined executive sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'high-performance sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'electric luxury sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'sporty executive sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'dynamic luxury sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'scandinavian luxury sedan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'sleek executive sedan',
      description: '', // Case vide pour ton texte
    ),
    // Coupe (10 voitures)
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
      subtitle: 'sporty luxury coupe',
      description: '', // Case vide pour ton texte
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
      subtitle: 'elegant luxury coupe',
      description: '', // Case vide pour ton texte
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
      subtitle: 'refined sporty coupe',
      description: '', // Case vide pour ton texte
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
      subtitle: 'iconic high-performance coupe',
      description: '', // Case vide pour ton texte
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
      subtitle: 'classic muscle coupe',
      description: '', // Case vide pour ton texte
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
      subtitle: 'legendary sporty coupe',
      description: '', // Case vide pour ton texte
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
      subtitle: 'powerful muscle coupe',
      description: '', // Case vide pour ton texte
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
      subtitle: 'dynamic sporty coupe',
      description: '', // Case vide pour ton texte
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
      subtitle: 'agile performance coupe',
      description: '', // Case vide pour ton texte
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
      subtitle: 'sleek luxury coupe',
      description: '', // Case vide pour ton texte
    ),
    // Minivan (10 voitures)
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
      subtitle: 'family-friendly minivan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'spacious family minivan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'reliable travel minivan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'modern family minivan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'versatile family van',
      description: '', // Case vide pour ton texte
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
      subtitle: 'practical travel minivan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'luxury family minivan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'rugged utility minivan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'comfortable family minivan',
      description: '', // Case vide pour ton texte
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
      subtitle: 'futuristic family minivan',
      description: '', // Case vide pour ton texte
    ),
    // Pickup (10 voitures)
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
      subtitle: 'heavy-duty pickup truck',
      description: '', // Case vide pour ton texte
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
      subtitle: 'rugged utility pickup',
      description: '', // Case vide pour ton texte
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
      subtitle: 'powerful off-road pickup',
      description: '', // Case vide pour ton texte
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
      subtitle: 'versatile mid-size pickup',
      description: '', // Case vide pour ton texte
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
      subtitle: 'durable full-size pickup',
      description: '', // Case vide pour ton texte
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
      subtitle: 'premium utility pickup',
      description: '', // Case vide pour ton texte
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
      subtitle: 'adventurous off-road pickup',
      description: '', // Case vide pour ton texte
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
      subtitle: 'compact rugged pickup',
      description: '', // Case vide pour ton texte
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
      subtitle: 'mid-size utility pickup',
      description: '', // Case vide pour ton texte
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
      subtitle: 'heavy-duty off-road pickup',
      description: '', // Case vide pour ton texte
    ),
  ];

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

  // Fonction pour trouver la voiture dans la liste et récupérer son sous-titre et sa description
  Vehicle? _findVehicle() {
    return allVehicles.firstWhere(
      (vehicle) => vehicle.name == widget.name && vehicle.category == widget.category,
      orElse: () => Vehicle(
        category: widget.category,
        name: widget.name,
        imageUrl: widget.imageUrl,
        doors: widget.doors,
        passengers: widget.passengers,
        luggage: widget.luggage,
        transmission: widget.transmission,
        pricePerDay: widget.pricePerDay,
        estimatedTotal: widget.estimatedTotal,
        features: [],
        minDriverAge: '21',
        subtitle: 'default vehicle',
        description: '',
      ),
    );
  }

  // Fonction pour afficher la pop-up
  void _showConditionsPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Permet de fermer la pop-up en cliquant à l'extérieur
      barrierColor: Colors.black.withOpacity(0.3), // Fond semi-transparent
      builder: (BuildContext context) {
        return const ConditionsPopup(); // Utiliser le widget ConditionsPopup
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int durationDays = calculateDuration(widget.pickupDate, widget.dropoffDate);

    // Récupérer la voiture pour obtenir le sous-titre et la description
    final vehicle = _findVehicle();

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // En-tête avec le rectangle bleu
            _buildHeader(screenWidth, durationDays, context),
            // Contenu principal (image, détails, etc.)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image de la voiture avec fond gris
                    _buildCarImage(),
                    // Détails de la voiture (nom, sous-titre, caractéristiques, description, prix)
                    _buildCarDetails(context, screenWidth, vehicle!.subtitle, vehicle.description),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construit l'en-tête avec le rectangle bleu
  Widget _buildHeader(double screenWidth, int durationDays, BuildContext context) {
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFF004852),
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne avec icônes et titre "REVIEW DETAILS"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Retour à SearchResultScreen
                },
              ),
              Text(
                'REVIEW DETAILS',
                style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LeagueSpartan-Bold',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Logique de partage (non implémentée ici)
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Construit l'image de la voiture avec un fond gris
  Widget _buildCarImage() {
    return Container(
      color: Colors.grey.shade300, // Fond gris uniquement pour l'image
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Image.asset(
        widget.imageUrl,
        width: 300,
        height: 200,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.directions_car, size: 120, color: Colors.black54);
        },
      ),
    );
  }

  // Construit les détails de la voiture (nom, sous-titre, caractéristiques, description, prix)
  Widget _buildCarDetails(BuildContext context, double screenWidth, String subtitle, String description) {
    return Container(
      color: Colors.white, // Fond blanc pour le reste de la page
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nom et sous-titre de la voiture
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'LeagueSpartan-Bold',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontFamily: 'LeagueSpartan-Light',
            ),
          ),
          const SizedBox(height: 20),
          // Caractéristiques (transmission, sièges, portes, bagages)
          _buildFeatureRow(Icons.settings, 'Automatic transmission', widget.transmission),
          _buildDivider(),
          _buildFeatureRow(Icons.person, 'Seats', widget.passengers.toString()),
          _buildDivider(),
          _buildFeatureRow(Icons.door_back_door_outlined, 'Doors', widget.doors.toString()),
          _buildDivider(),
          _buildFeatureRow(Icons.luggage, 'Luggage', widget.luggage.toString()),
          const SizedBox(height: 20),
          // Description
          const Text(
            'Car description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'LeagueSpartan-SemiBold',
            ),
          ),
          const SizedBox(height: 8),
          // Affichage de la description avec "Read more..." après 4 lignes
          description.isEmpty
              ? const Text(
                  'No description available.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: 'LeagueSpartan-Light',
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _isExpanded
                        ? Text(
                            description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontFamily: 'LeagueSpartan-Light',
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontFamily: 'LeagueSpartan-Light',
                                  ),
                                ),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isExpanded = true; // Affiche la description complète
                                      });
                                    },
                                    child: const Text(
                                      ' Read more...',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'LeagueSpartan-Light',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                    if (_isExpanded)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = false; // Masque la description complète
                          });
                        },
                        child: const Text(
                          'Read less',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontFamily: 'LeagueSpartan-Light',
                          ),
                        ),
                      ),
                  ],
                ),
          const SizedBox(height: 20),
          // Prix total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'LeagueSpartan-Bold',
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      // Logique pour afficher les détails du prix (non implémentée ici)
                    },
                    child: const Text(
                      'Price details',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontFamily: 'LeagueSpartan-Light',
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.estimatedTotal.replaceAll(' est. total', ''),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'LeagueSpartan-Bold',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Bouton "Reserve" qui ouvre la pop-up
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showConditionsPopup(context); // Afficher la pop-up
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004852),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Reserve',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'LeagueSpartan-Bold',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Construit une ligne pour une caractéristique (icône + texte)
  Widget _buildFeatureRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontFamily: 'LeagueSpartan-SemiBold',
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontFamily: 'LeagueSpartan-Light',
            ),
          ),
        ],
      ),
    );
  }

  // Construit un séparateur
  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 1,
      height: 1,
    );
  }
}