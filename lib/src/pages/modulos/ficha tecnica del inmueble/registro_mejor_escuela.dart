import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_bienestar_page.dart';
import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_edit_page.dart';
import 'package:app_ciudadana/src/pages/modulos/escuelas_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MejorEscuelaRegistro extends StatefulWidget {
  const MejorEscuelaRegistro({super.key});

  @override
  _MejorEscuelaRegistroState createState() => _MejorEscuelaRegistroState();
}

class _MejorEscuelaRegistroState extends State<MejorEscuelaRegistro> {
  final _formKey = GlobalKey<FormState>();

  String? anio;
  String? descripcion;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mejor escuela'),
        backgroundColor: Color(0xff59554e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  anio = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca el año',
                ),
              ),
              TextField(
                maxLines: 10,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  descripcion = value;
                },
                decoration: const InputDecoration(
                  hintText: 'descripcion',
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
                        'anio': anio,
                        'descripcion': descripcion,
                      };
                      await _firestore
                          .collection('usuarios')
                          .doc(user.uid)
                          .collection('mejorEscuela')
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
    );
  }
}
