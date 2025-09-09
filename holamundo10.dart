import 'package:flutter/material.dart';
import 'main.dart';

class HolaMundo10 extends StatefulWidget {
  const HolaMundo10({super.key});

  @override
  State<HolaMundo10> createState() => _HolaMundo10State();
}

class _HolaMundo10State extends State<HolaMundo10> {
  List<String> mensajes = [];

  void mostrarMensajes() {
    setState(() {
      mensajes = List.generate(10, (index) => '¡Hola Mundo!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Práctica 1: Hola Mundo 10',
      currentPage: 'HolaMundo10',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: mostrarMensajes,
              child: const Text('Mostrar Mensajes'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mensajes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      mensajes[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
