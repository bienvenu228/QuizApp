import 'package:flutter/material.dart';

class PhaseSelectionScreen extends StatelessWidget {
  final String token;
  final Map user;

  const PhaseSelectionScreen({required this.token, required this.user, super.key});

  // Fonction pour aller à l'écran ThemeScreen
  void _goToTheme(BuildContext context, String phase) {
    Navigator.pushNamed(
      context,
      '/themes',
      arguments: {
        'token': token,
        'user': user,
        'phase': phase, // Phase sélectionnée
      },
    );
  }

  // Navigation via BottomNavigationBar
  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
          context,
          '/login',
        );
        break;
      case 1:
        Navigator.pushReplacementNamed(
          context,
          '/stats',
          arguments: {'user': user, 'token': token},
        );
        break;
      case 2:
        // Page actuelle : Phases
        break;
      case 3:
        Navigator.pushReplacementNamed(
          context,
          '/profile',
          arguments: {'token': token, 'user': user},
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisissez une Phase'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Choisissez une phase pour commencer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Boutons des phases
            ElevatedButton(
              onPressed: () => _goToTheme(context, 'Phase1'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(18),
              ),
              child: const Text(
                'Phase 1 : Débutant - Algorithmique',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => _goToTheme(context, 'Phase2'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.all(18),
              ),
              child: const Text(
                'Phase 2 : Intermédiaire - Programmation',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => _goToTheme(context, 'Phase3'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.all(18),
              ),
              child: const Text(
                'Phase 3 : Avancé - POO',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),

      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Phases
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _navigate(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Phases'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
