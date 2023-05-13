import 'package:flutter/material.dart';

class EspecialesPage extends StatefulWidget {
  const EspecialesPage({super.key});

  @override
  State<EspecialesPage> createState() => _EspecialesPageState();
}

class _EspecialesPageState extends State<EspecialesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        title: const Text('Especiales'),
        centerTitle: true,
      ),
    );
  }
}
