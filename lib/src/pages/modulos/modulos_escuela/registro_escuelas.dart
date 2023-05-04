import 'dart:typed_data';

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

// final currentUser = _auth.currentUser!;
// final userRef = _firestore.collection('users').doc(currentUser.uid);

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
      appBar: AppBar(
        title: const Text('Registro de Escuela'),
        backgroundColor: Color(0xff59554e),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffa1c1be), Color(0xff9ec4bb), Color(0xffeed7c5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text('Fecha: $currentDateString',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Introduzca su CTT',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce tu CTT';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      ctt = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nombre de la escuela',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce el nombre de la escuela';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      nombreEscuela = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: DropdownButtonFormField<String>(
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
                    decoration: InputDecoration(
                      hintText: 'Selecciona el nivel escolar',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    onChanged: (value) {
                      turno = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Seleecionar turno',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      calle = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Calle',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      colonia = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Colonia',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      numero = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Numero',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      municipio = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Alcaldia / Municipio',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      codigoPostal = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Codigo Postal',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      nombreContacto = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Nombre y apellido',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      correoElectronico = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Correo Electronico',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      telefono = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Numero de telefono',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    'Ingrese su firma',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Signature(
                    controller: _controller,
                    height: 300,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
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

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (_) => const EscuelasScreen()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Formulario agregado correctamente'),
                            ),
                          );

                          // final signature = await _controller.toPngBytes();
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: const Text('Agregar escuela'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff59554e))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveSignature(Uint8List signatureBytes) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final signatureRef = _firestore.collection('signatures').doc(user.uid);
        await signatureRef.set({'signatureBytes': signatureBytes});
      }
    } catch (e) {
      print(e);
    }
  }
}
