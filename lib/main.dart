import 'package:flutter/material.dart';
import 'login.dart';
// import 'register.dart';
import 'stats.dart';
import 'phases.dart';
import 'themes.dart';
import 'quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool hasKeys(Map<String, dynamic>? args, List<String> keys) {
    if (args == null) return false;
    return keys.every((key) => args.containsKey(key));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginScreen());

          // On supprime la route nommée /register pour éviter l'erreur
          case '/stats':
            return MaterialPageRoute(builder: (_) => StatsScreen(), settings: settings);

          case '/phases':
            if (hasKeys(args, ['token', 'user'])) {
              return MaterialPageRoute(
                builder: (_) => PhaseSelectionScreen(
                  token: args!['token'],
                  user: args['user'],
                ),
              );
            }
            break;

          case '/themes':
            if (hasKeys(args, ['token', 'user', 'phase'])) {
              return MaterialPageRoute(
                builder: (_) => ThemeScreen(
                  token: args!['token'],
                  user: args['user'],
                  phase: args['phase'],
                ),
              );
            }
            break;

          case '/quiz':
            if (hasKeys(args, ['token', 'user', 'phase', 'theme'])) {
              return MaterialPageRoute(
                builder: (_) => QuizScreen(
                  token: args!['token'],
                  user: args['user'],
                  phase: args['phase'],
                  theme: args['theme'],
                ),
              );
            }
            break;
        }

        // Page non trouvée
        return MaterialPageRoute(
          builder: (_) => NotFoundScreen(routeName: settings.name ?? 'unknown'),
        );
      },
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  final String routeName;
  const NotFoundScreen({required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erreur')),
      body: Center(
        child: Text('Page non trouvée : $routeName'),
      ),
    );
  }
}
