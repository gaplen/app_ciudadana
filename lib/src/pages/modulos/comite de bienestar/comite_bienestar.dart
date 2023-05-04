import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_bienestar_page.dart';
import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_edit_page.dart';
import 'package:app_ciudadana/src/pages/modulos/escuelas_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistroComiteBienestar extends StatefulWidget {
  const RegistroComiteBienestar({super.key});

  @override
  _RegistroComiteBienestarState createState() =>
      _RegistroComiteBienestarState();
}

class _RegistroComiteBienestarState extends State<RegistroComiteBienestar> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro comite bienestar'),
        backgroundColor: Color(0xff59554e),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Puesto',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      puesto = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nombre',
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
                        return 'Por favor, introduce tu nombre';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      nombre = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Apellido Paterno',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      aPaterno = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Apellido Materno',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      aMaterno = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Telefono',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      telefono = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Curp',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      curp = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Calle',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      calle = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Numero',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      numero = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Colonia',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      colonia = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'C.P.',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      codigoPostal = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Municipio',
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
                        return 'Por favor, introduce tu puesto';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      municipio = value;
                    },
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
                        };
                        await _firestore
                            .collection('usuarios')
                            .doc(user.uid)
                            .collection('comiteBienestar')
                            .add(data);
                        // .get();
                        //   .update(
                        // {
                        //   'escuela': FieldValue.arrayUnion([data])
                        // },
                        // );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => const ComiteBienestarPage()),
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
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff59554e),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
