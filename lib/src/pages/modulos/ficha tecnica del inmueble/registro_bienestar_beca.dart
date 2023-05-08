import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_bienestar_page.dart';
import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_edit_page.dart';
import 'package:app_ciudadana/src/pages/modulos/escuelas_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistroBienestarBeca extends StatefulWidget {
  const RegistroBienestarBeca({super.key});

  @override
  _RegistroBienestarBecaState createState() => _RegistroBienestarBecaState();
}

class _RegistroBienestarBecaState extends State<RegistroBienestarBeca> {
  final _formKey = GlobalKey<FormState>();
  String? nivel;
  String? anio;
  String? descripcion;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  List<String> ctt = [
    'Alumnos Beneficiados CTT1',
    'Alumnos Beneficiados CTT2',
    'Alumnos Beneficiados CTT3',
    'Alumnos Beneficiados CTT4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        title: const Text('registroBienestar'),
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
                  child: DropdownButtonFormField<String>(
                    value: nivel,
                    items: ctt.map((String value) {
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
                      hintText: 'Selecciona CTT',
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
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      anio = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Introduzca el año',
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
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextField(
                    maxLines: 10,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      descripcion = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Descripcion',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      Future.delayed(Duration(seconds: 5), () {
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Formulario agregado correctamente'),
                          ),
                        );
                        Navigator.pop(
                            context); // Cerrar el formulario después de 10 segundos
                      });
                      try {
                        final user = await _auth.currentUser;
                        if (user != null) {
                          final data = {
                            'anio': anio,
                            'descripcion': descripcion,
                            // 'numCTT': numCTT,
                            'nivel': nivel,
                          };
                          await _firestore
                              .collection('usuarios')
                              .doc(user.uid)
                              .collection('bienestarBecas')
                              .add(data);
                          Navigator.pop(context);

                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //       builder: (_) => const ComiteBienestarPage()),
                          // );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Formulario agregado correctamente'),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Agregar usuario'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff59554e))),
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
