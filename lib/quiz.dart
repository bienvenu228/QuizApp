import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String token;
  final Map user;
  final String phase;
  final String theme;

  const QuizScreen({
    required this.token,
    required this.user,
    required this.phase,
    required this.theme,
    super.key,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  String? _selectedAnswer;

  // Questions par phase et thème
  final Map<String, Map<String, List<Map<String, dynamic>>>> _questionsByPhaseTheme = {
    'Phase1': {
      'Thème 1 : Variables': [
        {
          'question': 'Quelle est la syntaxe pour déclarer une variable entière en Dart ?',
          'options': ['int x = 5;', 'var x;', 'x := 5', 'int x := 5;'],
          'answer': 'int x = 5;',
        },
        {
          'question': 'Quelle valeur prendra une variable non initialisée en Dart ?',
          'options': ['0', 'null', 'undefined', 'false'],
          'answer': 'null',
        },
      ],
      'Thème 2 : Conditions': [
        {
          'question': 'Quelle syntaxe correcte pour une condition en Dart ?',
          'options': ['if (x > 5) {}', 'if x > 5 {}', 'if x > 5:', 'if (x > 5):'],
          'answer': 'if (x > 5) {}',
        },
        {
          'question': 'Quelle instruction utilise-t-on pour gérer plusieurs cas ?',
          'options': ['switch', 'if', 'for', 'while'],
          'answer': 'switch',
        },
      ],
      'Thème 3 : Boucles': [
        {
          'question': 'Comment écrire une boucle for en Dart ?',
          'options': ['for (int i=0; i<5; i++) {}', 'for i in range(5):', 'for i=0; i<5; i++', 'foreach(i in 0..5)'],
          'answer': 'for (int i=0; i<5; i++) {}',
        },
        {
          'question': 'Quelle boucle continue tant que la condition est vraie ?',
          'options': ['while', 'for', 'do-while', 'loop'],
          'answer': 'while',
        },
      ],
    },
    'Phase2': {
      'Thème 1 : Variables': [
        {
          'question': 'Quelle est la différence entre var et final en Dart ?',
          'options': ['var peut changer, final ne peut pas', 'var et final sont identiques', 'var ne peut pas changer, final peut changer', 'final est utilisé seulement pour les String'],
          'answer': 'var peut changer, final ne peut pas',
        },
      ],
      'Thème 2 : Conditions': [
        {
          'question': 'Comment combiner deux conditions avec ET logique en Dart ?',
          'options': ['&&', '||', 'and', '&'],
          'answer': '&&',
        },
      ],
      'Thème 3 : Boucles': [
        {
          'question': 'Comment sortir immédiatement d’une boucle en Dart ?',
          'options': ['break', 'exit', 'continue', 'stop'],
          'answer': 'break',
        },
      ],
    },
    'Phase3': {
      'Thème 1 : Variables': [
        {
          'question': 'Quelle est la portée d’une variable définie dans une fonction ?',
          'options': ['locale', 'globale', 'statique', 'publique'],
          'answer': 'locale',
        },
      ],
      'Thème 2 : Conditions': [
        {
          'question': 'Quelle structure permet de vérifier plusieurs conditions en cascade ?',
          'options': ['if-else if', 'switch', 'for', 'while'],
          'answer': 'if-else if',
        },
      ],
      'Thème 3 : Boucles': [
        {
          'question': 'Quelle boucle exécute au moins une fois, même si la condition est fausse ?',
          'options': ['do-while', 'while', 'for', 'foreach'],
          'answer': 'do-while',
        },
      ],
    },
  };

  List<Map<String, dynamic>> get _questions => _questionsByPhaseTheme[widget.phase]?[widget.theme] ?? [];

  void _nextQuestion() {
    if (_selectedAnswer == _questions[_currentQuestionIndex]['answer']) _score++;

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
      });
    } else {
      _showScoreDialog();
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Quiz terminé !'),
        content: Text('Vous avez obtenu $_score/${_questions.length} points.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Ferme le dialog
              Navigator.pop(context); // Retour aux phases
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.phase} - ${widget.theme}'),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Center(child: Text('Aucune question disponible pour ce thème.')),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.phase} - ${widget.theme}'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} sur ${_questions.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(question['question'], style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...List.generate(
              question['options'].length,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedAnswer == question['options'][i] ? Colors.deepPurple : Colors.grey[300],
                    foregroundColor: _selectedAnswer == question['options'][i] ? Colors.white : Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => setState(() => _selectedAnswer = question['options'][i]),
                  child: Text(question['options'][i], style: const TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedAnswer == null ? null : _nextQuestion,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Suivant'),
            ),
          ],
        ),
      ),
    );
  }
}
