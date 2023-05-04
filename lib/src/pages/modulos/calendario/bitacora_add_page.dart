import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class BitacoraAddPage extends StatefulWidget {
  const BitacoraAddPage({super.key});

  @override
  State<BitacoraAddPage> createState() => _BitacoraAddPageState();
}

class _BitacoraAddPageState extends State<BitacoraAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  String? title;
  String? fecha;
  String? descripcion;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final currentDateString = _dateFormat.format(currentDate);
    return Scaffold(
      appBar: AppBar(
        title: Text('bitacora add'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Fecha: $currentDateString',
                    style: const TextStyle(fontSize: 16)),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Introduzca asunto',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    descripcion = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Introduzca una descripcion',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = await _auth.currentUser;
                      if (user != null) {
                        final data = {
                          'date': FieldValue.serverTimestamp(),
                          'title': title,
                          'description': descripcion,
                        };

                        await _firestore
                            .collection('usuarios')
                            .doc(user.uid)
                            .collection('events')
                            .add(data);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Formulario agregado correctamente'),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Agregar usuario'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
