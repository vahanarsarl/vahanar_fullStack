import 'package:flutter/material.dart';
import 'package:vahanar_front/widgets/bottom_nav_bar.dart';

class ReservationsHistoryScreen extends StatelessWidget {
  const ReservationsHistoryScreen({Key? key}) : super(key: key); // Ajout de Key? key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec flèche de retour et titre
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              color: const Color(0xFF2A4D50), // Couleur verte foncée du header
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context); // Retour à la page précédente
                        },
                      ),
                      const Text(
                        'RESERVATIONS',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'LeagueSpartan-Bold',
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                      // Suppression de l'IconButton du menu
                      const SizedBox(width: 48), //Pour aligner le titre au centre
                    ],
                  ),
                  const Text(
                    'HISTORY',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'LeagueSpartan-Bold',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre "Active Orders"
                      const Text(
                        'Active Orders',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LeagueSpartan-Bold',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Liste des commandes actives
                      _buildOrderList(context, [
                        {
                          'location': 'Mohamed V Intl Airport, casab...',
                          'type': 'Pick-up location',
                          'date': 'Mar 22, 2025',
                          'status': 'Confirmed'
                        },
                        {
                          'location': 'Mohamed V Intl Airport, casab...',
                          'type': 'Drop-off location',
                          'date': 'Mar 24, 2025',
                          'status': 'Confirmed'
                        },
                      ]),
                      const SizedBox(height: 16.0),
                      // Titre "Past Orders"
                      const Text(
                        'Past Orders',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LeagueSpartan-Bold',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Liste des commandes passées
                      _buildOrderList(context, [
                        {
                          'location': 'Mohamed V Intl Airport, casab...',
                          'type': 'Pick-up location',
                          'date': 'Jan 15, 2025',
                          'status': 'Completed'
                        },
                        {
                          'location': 'Mohamed V Intl Airport, casab...',
                          'type': 'Drop-off location',
                          'date': 'Jan 17, 2025',
                          'status': 'Completed'
                        },
                        {
                          'location': 'Mohamed V Intl Airport, casab...',
                          'type': 'Pick-up location',
                          'date': 'Dec 10, 2024',
                          'status': 'Completed'
                        },
                        {
                          'location': 'Mohamed V Intl Airport, casab...',
                          'type': 'Drop-off location',
                          'date': 'Dec 12, 2024',
                          'status': 'Completed'
                        },
                        {
                          'location': 'Mohamed V Intl Airport, casab...',
                          'type': 'Pick-up location',
                          'date': 'Nov 5, 2024',
                          'status': 'Completed'
                        },
                        {
                          'location': 'Mohamed V Intl Airport, casab...',
                          'type': 'Drop-off location',
                          'date': 'Nov 7, 2024',
                          'status': 'Completed'
                        },
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2), // Index 2 pour "My Reservations"
    );
  }

  // Méthode pour construire la liste des commandes
  Widget _buildOrderList(BuildContext context, List<Map<String, String>> orders) {
    return Column(
      children: orders.map((order) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFF2A4D50),
                  size: 30,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['location'] ?? 'Location inconnue',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'LeagueSpartan-Light',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        order['type'] ?? 'Type inconnu',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'LeagueSpartan-Light',
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Date: ${order['date'] ?? 'Unknown'}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'LeagueSpartan-Light',
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Status: ${order['status'] ?? 'Unknown'}',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'LeagueSpartan-Light',
                          color: order['status'] == 'Confirmed' ? Colors.green : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}