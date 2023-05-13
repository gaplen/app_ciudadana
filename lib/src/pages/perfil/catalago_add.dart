import 'dart:typed_data';

import 'package:app_ciudadana/src/utils/internet_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class AddEtiqueta extends StatefulWidget {
  const AddEtiqueta({super.key});

  @override
  _AddEtiquetaState createState() => _AddEtiquetaState();
}

Uint8List? image;
// Color inicial del botón

class _AddEtiquetaState extends State<AddEtiqueta> {
  final _formKey = GlobalKey<FormState>();

  String? nombre;
  String? descripcion;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Etiqueta'),
        centerTitle: true,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Introduzca titulo',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      nombre = value;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final user = await _auth.currentUser;
                        if (user != null) {
                          Future.delayed(Duration(seconds: 5), () {
                            CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Formulario agregado correctamente'),
                              ),
                            );
                            Navigator.pop(
                                context); // Cerrar el formulario después de 10 segundos
                          });
                          final data = {
                            'fecha': FieldValue.serverTimestamp(),
                            'nombre': nombre,
                            // 'descripcion': descripcion,
                          };
                          await _firestore
                              .collection('usuarios')
                              .doc(user.uid)
                              .collection('etiquetas')
                              .add(data);

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Formulario agregado correctamente'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        Navigator.pop(context);
                      }
                    } else {
                      return Utils.showTopSnackBar(context,
                          'Por favor, llena todos los campos', Colors.red);
                    }
                  },
                  child: const Text('Añadir etiqueta'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff59554e))),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
