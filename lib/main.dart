import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonidos de Animales',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SoundboardPage(),
    );
  }
}

class SoundboardPage extends StatefulWidget {
  const SoundboardPage({super.key});

  @override
  State<SoundboardPage> createState() => _SoundboardPageState();
}

class _SoundboardPageState extends State<SoundboardPage> {
  final AudioPlayer _player = AudioPlayer();

  final List<Map<String, dynamic>> _animales = [
    {'nombre': 'Perro',   'sonido': 'dog.mp3',   'emoji': '🐶', 'color': Colors.orange},
    {'nombre': 'Gato',    'sonido': 'cat.mp3',   'emoji': '🐱', 'color': Colors.purple},
    {'nombre': 'Vaca',    'sonido': 'cow.mp3',   'emoji': '🐮', 'color': Colors.brown},
    {'nombre': 'Cerdo',   'sonido': 'pig.mp3',   'emoji': '🐷', 'color': Colors.pink},
    {'nombre': 'Caballo', 'sonido': 'horse.mp3', 'emoji': '🐴', 'color': Colors.teal},
    {'nombre': 'Pato',    'sonido': 'duck.mp3',  'emoji': '🦆', 'color': Colors.blue},
    {'nombre': 'Gallo',   'sonido': 'cock.mp3',  'emoji': '🐓', 'color': Colors.red},
    {'nombre': 'León',    'sonido': 'lion.mp3',  'emoji': '🦁', 'color': Colors.amber},
    {'nombre': 'Oveja',   'sonido': 'sheep.mp3', 'emoji': '🐑', 'color': Colors.green},
  ];

  Future<void> _reproducir(String sonido) async {
    await _player.stop();
    await _player.play(AssetSource(sonido));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Widget _buildCard(Map<String, dynamic> animal) {
    final color = animal['color'] as Color;
    return GestureDetector(
      onTap: () => _reproducir(animal['sonido']),
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              animal['emoji'],
              style: const TextStyle(fontSize: 52),
            ),
            const SizedBox(height: 8),
            Text(
              animal['nombre'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🐾 Sonidos de Animales'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: _animales.map(_buildCard).toList(),
        ),
      ),
    );
  }
}