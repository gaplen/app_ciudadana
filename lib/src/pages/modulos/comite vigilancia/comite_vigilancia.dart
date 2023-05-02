import 'package:app_ciudadana/src/pages/modulos/comite%20vigilancia/comite_vigilancia_page.dart';
import 'package:app_ciudadana/src/pages/modulos/escuelas_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistroComiteVigilancia extends StatefulWidget {
  const RegistroComiteVigilancia({super.key});

  @override
  _RegistroComiteVigilanciaState createState() =>
      _RegistroComiteVigilanciaState();
}

class _RegistroComiteVigilanciaState extends State<RegistroComiteVigilancia> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  String? puesto;
  String? nombre;
  String? aPaterno;
  String? aMaterno;
  String? telefono;
  String? curp;
  String? calle;
  String? numero;
  String? colonia;
  String? codigoPostal;
  String? municipio;
  String? firma;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  List<String> niveles = [
    'Preescolar',
    'Primaria',
    'Secundaria',
    'Media Superior',
  ];

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
      appBar: AppBar(title: const Text('Registro comite vigilancia')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Text(
              //   'Fecha: $currentDateString',
              //   style: const TextStyle(fontSize: 16),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  puesto = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su puesto',
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  nombre = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su nombre',
                ),
              ),
              TextField(
                onChanged: (value) {
                  aPaterno = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su apellido paterno',
                ),
              ),
              TextField(
                onChanged: (value) {
                  aMaterno = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su apellido materno',
                ),
              ),
              TextField(
                onChanged: (value) {
                  telefono = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su telefono',
                ),
              ),
              TextField(
                onChanged: (value) {
                  curp = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su curp',
                ),
              ),
              TextField(
                onChanged: (value) {
                  calle = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su calle',
                ),
              ),
              TextField(
                onChanged: (value) {
                  numero = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su numero',
                ),
              ),
              TextField(
                onChanged: (value) {
                  colonia = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su colonia',
                ),
              ),
              TextField(
                onChanged: (value) {
                  codigoPostal = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su codigo postal',
                ),
              ),
              TextField(
                onChanged: (value) {
                  municipio = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su municipio',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final user = await _auth.currentUser;
                    if (user != null) {
                      final data = {
                        'fecha': FieldValue.serverTimestamp(),
                        'puesto': puesto,
                        'nombre': nombre,
                        'aPaterno': aPaterno,
                        'aMaterno': aMaterno,
                        'telefono': telefono,
                        'curp': curp,
                        'calle': calle,
                        'numero': numero,
                        'colonia': colonia,
                        'codigoPostal': codigoPostal,
                        'municipio': municipio,

                        // 'campo3': '',
                      };
                      await _firestore
                          .collection('usuarios')
                          .doc(user.uid)
                          .collection('comiteVigilancia')
                          .add(data);
                      // .get();
                      //   .update(
                      // {
                      //   'escuela': FieldValue.arrayUnion([data])
                      // },
                      // );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => const ComiteVigilanciaPage()),
                      );
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
    );
  }
}
