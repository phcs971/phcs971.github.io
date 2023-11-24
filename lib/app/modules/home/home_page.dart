import 'package:dragonflylabs/app/widgets/interactive_builder.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return InteractiveBuilder((context, device) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Dragonfly Studios'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      );
    });
  }
}
