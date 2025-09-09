import 'package:flutter/material.dart';
import 'holamundo10.dart';
import 'holamundoincremental.dart';
import 'registro_screen.dart';
import 'piedrapapeltijera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mis Prácticas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HolaMundo10(),
    );
  }
}

// Base Scaffold con Drawer común y botón flotante opcional
class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final String currentPage;
  final FloatingActionButton? floatingActionButton;  // <-- Agregado

  const BaseScaffold({
    Key? key,
    required this.title,
    required this.body,
    required this.currentPage,
    this.floatingActionButton, // <-- Agregado
  }) : super(key: key);

  void _navigate(BuildContext context, String page) {
    if (page == currentPage) {
      Navigator.pop(context);
      return;
    }
    Widget destination;
    switch (page) {
      case 'HolaMundo10':
        destination = const HolaMundo10();
        break;
      case 'HolaMundoIncremental':
        destination = const HolaMundoIncremental();
        break;
      case 'Registro':
        destination = const RegistroScreen();
        break;
      case 'PiedraPapelTijera':
        destination = const PiedraPapelTijera();
        break;
      default:
        destination = const HolaMundo10();
    }
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => destination));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Center(
                child: Text(
                  'Menú de Prácticas',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.looks_one),
              title: const Text('Práctica 1 - Hola Mundo 10'),
              selected: currentPage == 'HolaMundo10',
              onTap: () => _navigate(context, 'HolaMundo10'),
            ),
            ListTile(
              leading: const Icon(Icons.looks_two),
              title: const Text('Práctica 2 - Incremental'),
              selected: currentPage == 'HolaMundoIncremental',
              onTap: () => _navigate(context, 'HolaMundoIncremental'),
            ),
            ListTile(
              leading: const Icon(Icons.looks_3),
              title: const Text('Práctica 3 - Registro'),
              selected: currentPage == 'Registro',
              onTap: () => _navigate(context, 'Registro'),
            ),
            ListTile(
              leading: const Icon(Icons.games),
              title: const Text('Práctica 4 - Piedra, Papel o Tijera'),
              selected: currentPage == 'PiedraPapelTijera',
              onTap: () => _navigate(context, 'PiedraPapelTijera'),
            ),
          ],
        ),
      ),
      body: body,
      floatingActionButton: floatingActionButton,  // <-- Aquí lo uso
    );
  }
}
