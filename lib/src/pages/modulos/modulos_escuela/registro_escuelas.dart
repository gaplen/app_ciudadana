import 'package:app_ciudadana/src/pages/modulos/escuelas_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class RegistroEscuela extends StatefulWidget {
  const RegistroEscuela({super.key});

  @override
  _RegistroEscuelaState createState() => _RegistroEscuelaState();
}

class _RegistroEscuelaState extends State<RegistroEscuela> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  String? ctt;
  String? nombreEscuela;
  String? nivel;
  String? turno;
  String? calle;
  String? numero;
  String? colonia;
  String? municipio;
  String? codigoPostal;
  String? nombreContacto;
  String? correoElectronico;
  String? telefono;

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
    SignatureController _controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );
    final currentDate = DateTime.now();
    final currentDateString = _dateFormat.format(currentDate);
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Escuela')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Fecha: $currentDateString',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  ctt = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su cct',
                ),
              ),
              TextField(
                onChanged: (value) {
                  nombreEscuela = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca el nombre de la escuela',
                ),
              ),
              DropdownButtonFormField<String>(
                value: nivel,
                items: niveles.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    nivel = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Seleccione el nivel escolar',
                ),
              ),
              TextField(
                onChanged: (value) {
                  turno = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca el turno',
                ),
              ),
              TextField(
                onChanged: (value) {
                  calle = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca el nombre de la calle',
                ),
              ),
              TextField(
                onChanged: (value) {
                  colonia = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca el nombre de la colonia',
                ),
              ),
              TextField(
                onChanged: (value) {
                  numero = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca el numero',
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
              TextField(
                onChanged: (value) {
                  codigoPostal = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su C.P',
                ),
              ),
              TextField(
                onChanged: (value) {
                  nombreContacto = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca nombre y apellido',
                ),
              ),
              TextField(
                onChanged: (value) {
                  correoElectronico = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su email',
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
              const SizedBox(
                height: 40,
              ),
              const Text('ingrese su firma'),
              Signature(
                controller: _controller,
                height: 300,
                backgroundColor: Colors.white,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final user = await _auth.currentUser;
                    if (user != null) {
                      final data = {
                        'fecha': FieldValue.serverTimestamp(),
                        'ctt': ctt,
                        'nombreEscuela': nombreEscuela,
                        'nivel': nivel,
                        'turno': turno,
                        'calle': calle,
                        'numero': numero,
                        'colonia': colonia,
                        'municipio': municipio,
                        'codigoPostal': codigoPostal,
                        'nombreContacto': nombreContacto,
                        'correoElectronico': correoElectronico,
                        'telefono': telefono,

                        // 'campo3': '',
                      };
                      await _firestore
                          .collection('usuarios')
                          .doc(user.uid)
                          .collection('escuelas')
                          .add(data);

                      final data2 = {
                        'nombreContacto': nombreContacto,
                        'correoElectronico': correoElectronico,
                        'telefono': telefono,

                        // 'campo3': '',
                      };
                      await _firestore
                          .collection('usuarios')
                          .doc(user.uid)
                          .collection('contactos')
                          .add(data2);
                      // .get();
                      //   .update(
                      // {
                      //   'escuela': FieldValue.arrayUnion([data])
                      // },
                      // );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => const EscuelasScreen()),
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
                child: const Text('Agregar escuela'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
