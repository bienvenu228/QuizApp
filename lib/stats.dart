import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final user = args['user'];
    final token = args['token'];
    final points = args['points'] ?? 0;
    final quizzesCompleted = args['quizzesCompleted'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Statistiques'),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.deepPurple.shade100,
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Bienvenue ${user['name']} 👋',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(child: Text('Email : ${user['email']}')),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Token : $token',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),

            Card(
              color: Colors.deepPurple.shade50,
              elevation: 3,
              child: ListTile(
                leading: const Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 30,
                ),
                title: const Text('Points cumulés'),
                subtitle: Text(
                  '$points pts',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.green.shade50,
              elevation: 3,
              child: ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
                title: const Text('Quiz complétés'),
                subtitle: Text(
                  '$quizzesCompleted',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/phases',
                    arguments: {
                      'token': token,
                      'user': user, // ← Ajoute ceci
                    },
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Commencer un nouveau quiz'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  'Se déconnecter',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),

      // 🎯 BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: 2, // Index Stats
  selectedItemColor: Colors.deepPurple,
  unselectedItemColor: Colors.grey,
  onTap: (index) {
    switch (index) {
      case 0: // Accueil → Stats
        Navigator.pushReplacementNamed(
          context,
          '/stats',
          arguments: {'user': user, 'token': token},
        );
        break;
      case 1: // Quiz
        Navigator.pushReplacementNamed(
          context,
          '/quiz',
          arguments: {'user': user, 'token': token},
        );
        break;
      case 2: // Stats (page actuelle)
        break;
      case 3: // Profil
        Navigator.pushReplacementNamed(
          context,
          '/profile',
          arguments: {'user': user, 'token': token},
        );
        break;
    }
  },
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
    BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Quiz'),
    BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ],
  type: BottomNavigationBarType.fixed,
),
    );
  }
}