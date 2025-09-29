import 'package:eduquizz/stats.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homePages = [
    StatsScreen(),
    // PhaseScreen(),
    // ThemeScreen(),
    // QuestionScreen(),
  ];

  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // print(userProvider.fetchUsers());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homePages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_filled), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Phases'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), label: 'Thèmes'),
          NavigationDestination(icon: Icon(Icons.help_outline), label: 'Questions'),
        ]
      ),
    );
  }
}