import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const CookieClickerApp());
}

class CookieClickerApp extends StatelessWidget {
  const CookieClickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookie Clicker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  int _cookies = 0;
  int _cookiesPerClick = 1;
  int _autoClickers = 0;
  
  // Costos
  int _upgradeClickCost = 10;
  int _autoClickerCost = 50;

  Timer? _autoClickTimer;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animación para el click
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
    )..value = 1.0;

    // Timer para autoclickers (cada 1 segundo)
    _autoClickTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_autoClickers > 0) {
        setState(() {
          _cookies += _autoClickers;
        });
      }
    });
  }

  @override
  void dispose() {
    _autoClickTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _clickCookie() {
    setState(() {
      _cookies += _cookiesPerClick;
    });
    _controller.reverse().then((_) => _controller.forward());
  }

  void _buyClickUpgrade() {
    if (_cookies >= _upgradeClickCost) {
      setState(() {
        _cookies -= _upgradeClickCost;
        _cookiesPerClick++;
        _upgradeClickCost = (_upgradeClickCost * 1.5).floor();
      });
    }
  }

  void _buyAutoClicker() {
    if (_cookies >= _autoClickerCost) {
      setState(() {
        _cookies -= _autoClickerCost;
        _autoClickers++;
        _autoClickerCost = (_autoClickerCost * 1.5).floor();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookie Clicker'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Galletas: $_cookies',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(
            '$_cookiesPerClick por click | $_autoClickers por segundo',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: _clickCookie,
                child: ScaleTransition(
                  scale: _controller,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.brown,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.cookie,
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.brown[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Tienda',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.touch_app, color: Colors.brown),
                  title: const Text('Mejorar Click (+1)'),
                  subtitle: Text('Costo: $_upgradeClickCost galletas'),
                  trailing: ElevatedButton(
                    onPressed: _cookies >= _upgradeClickCost ? _buyClickUpgrade : null,
                    child: const Text('Comprar'),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.av_timer, color: Colors.brown),
                  title: const Text('Auto Clicker (+1/s)'),
                  subtitle: Text('Costo: $_autoClickerCost galletas'),
                  trailing: ElevatedButton(
                    onPressed: _cookies >= _autoClickerCost ? _buyAutoClicker : null,
                    child: const Text('Comprar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
