import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class MyNuevoCalendario extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String escuelaId;
  const MyNuevoCalendario(
      {super.key, required this.data, required this.escuelaId});

  @override
  State<MyNuevoCalendario> createState() => _MyNuevoCalendarioState();
}

class _MyNuevoCalendarioState extends State<MyNuevoCalendario> {
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final date =
        DateTime.fromMillisecondsSinceEpoch(widget.data['date'].seconds * 1000);
    return Scaffold(
      appBar: AppBar(title: Text('Nuevo Calendario')),
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Icon(Icons.calendar_today),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateFormat.parse(dateFormat.format(_selectedDate)),
      firstDate: DateTime(1900),
      // lastDate: DateTime.now(2100),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }
}
