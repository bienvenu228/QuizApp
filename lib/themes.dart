import 'package:flutter/material.dart';

class ThemeScreen extends StatelessWidget {
  final String token;
  final Map user;
  final String phase;

  const ThemeScreen({required this.token, required this.user, required this.phase, super.key});

  void _startQuiz(BuildContext context, String theme) {
    Navigator.pushNamed(
      context,
      '/quiz',
      arguments: {
        'token': token,
        'user': user,
        'phase': phase,
        'theme': theme,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themes = [
      'Thème 1 : Variables',
      'Thème 2 : Conditions',
      'Thème 3 : Boucles',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Phase $phase : Choisissez un thème'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: themes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 15),
          itemBuilder: (_, index) {
            return ElevatedButton(
              onPressed: () => _startQuiz(context, themes[index]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(18),
              ),
              child: Text(
                themes[index],
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
