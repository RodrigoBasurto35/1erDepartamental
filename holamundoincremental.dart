import 'package:flutter/material.dart';
import 'main.dart';

class HolaMundoIncremental extends StatefulWidget {
  const HolaMundoIncremental({super.key});

  @override
  State<HolaMundoIncremental> createState() => _HolaMundoIncrementalState();
}

class _HolaMundoIncrementalState extends State<HolaMundoIncremental> {
  int _counter = 0;

  void _incrementar() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Práctica 2: Incremental',
      currentPage: 'HolaMundoIncremental',
      body: Center(
        child: Text(
          '$_counter. ¡Hola Mundo!',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementar,
        tooltip: 'Incrementar',
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
