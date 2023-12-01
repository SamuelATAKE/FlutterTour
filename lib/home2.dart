// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class MyNiceHome extends StatefulWidget {
  const MyNiceHome({super.key});

  @override
  State<MyNiceHome> createState() => _MyNiceHomeState();
}

class _MyNiceHomeState extends State<MyNiceHome> {
  final GlobalKey _tour1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(height: 10),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    print('cool');
                  },
                  child: const Text('My button test')),
            ),
          ],
        ),
      ),
      floatingActionButton: Showcase(
        key: _tour1,
        title: 'Astuce',
        description: 'Veuillez cliquer sur ce bouton pour poursuivre',
        targetShapeBorder: const CircleBorder(),
        child: Builder(
          builder: (context) {
            return FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  ShowCaseWidget.of(context).startShowCase([_tour1]);
                });
              },
              child: const Icon(
                Icons.help,
              ),
            );
          }
        ),
      ),
    );
  }
}
