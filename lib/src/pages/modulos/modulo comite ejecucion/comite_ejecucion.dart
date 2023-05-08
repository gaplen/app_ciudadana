import 'dart:typed_data';

import 'package:app_ciudadana/src/pages/modulos/escuelas_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulo%20comite%20ejecucion/comote_ejecucion_page.dart';
import 'package:app_ciudadana/src/utils/internet_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class RegistroComitePage extends StatefulWidget {
  const RegistroComitePage({super.key});

  @override
  _RegistroComitePageState createState() => _RegistroComitePageState();
}

Uint8List? image;

class _RegistroComitePageState extends State<RegistroComitePage> {
  bool isSignatureEnabled = true;
  bool _isButtonEnabled = true; // Estado inicial del botón
  Color _buttonColor = Colors.green; //
  final SignatureController _controller = SignatureController(
      penStrokeWidth: 1,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white10);
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
      appBar: AppBar(
        title: const Text('Registro Comite de ejecucion'),
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
                      hintText: 'Puesto',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
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
                        return 'Por favor, introduce tu apellido paterno';
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
                        return 'Por favor, introduce tu apellido materno';
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
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: 'Telefono',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
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
                      hintText: 'CURP',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce tu CURP';
                      }
                      if (value.length < 18) {
                        return 'Por favor, introduce un CURP valido';
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
                    keyboardType: TextInputType.number,
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
                    onChanged: (value) {
                      municipio = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    'Ingrese su firma',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                _signature(Colors.white),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
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
                                .collection('comiteEjecucion')
                                .add(data);
                            // .get();
                            //   .update(
                            // {
                            //   'escuela': FieldValue.arrayUnion([data])
                            // },
                            // );

                            Navigator.pop(context);
                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //       builder: (_) => const ComiteEjecucionPage()),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signature(Color colorPrimario) {
    return Container(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          _signatureCanvas(),
          const SizedBox(
            height: 20,
          ),
          _botonesSignature(colorPrimario)
        ],
      ),
      //padding: EdgeInsets.only(right: 20),
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      decoration: BoxDecoration(
        //gradient: const Gradient(colors: Color.fromRGBO(58, 135, 205, 0.9)),
        //color: const Color(0xFF333366),
        color: colorPrimario,
        //color: const Color(0x99ccff),
        shape: BoxShape.rectangle,

        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(15.0, 20.0),
          ),
        ],
      ),
    );
  }

  Widget _botonesSignature(Color colorPrimario) {
    return Container(
      decoration: BoxDecoration(color: colorPrimario),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //SHOW EXPORTED IMAGE IN NEW ROUTE

            //CLEAR CANVAS
            FloatingActionButton.extended(
              heroTag: 'btn3',
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              extendedIconLabelSpacing: 10,
              extendedPadding: const EdgeInsets.all(15),
              label: const Text('Borrar'),
              icon: const Icon(Icons.restore_from_trash_rounded),
              onPressed: () {
                setState(() => _controller.clear());
                setState(() {
                  _isButtonEnabled = true;
                  _buttonColor = Colors.green;
                });
                image = null;
              },
            ),

            FloatingActionButton.extended(
              heroTag: 'btn4',
              backgroundColor: _buttonColor,
              foregroundColor: Colors.white,
              extendedIconLabelSpacing: 10,
              extendedPadding: const EdgeInsets.all(15),
              label: const Text('Guardar'),
              icon: const Icon(Icons.save),
              onPressed: _isButtonEnabled
                  ? () async {
                      if (_controller.isNotEmpty) {
                        final imageRaw = await _controller.toPngBytes();
                        if (imageRaw != null) {
                          image = imageRaw;
                          Utils.showTopSnackBar(
                              context, 'Firma Guardada', Colors.green);
                          setState(() {
                            _isButtonEnabled = false;
                            _buttonColor = Colors.grey;
                            isSignatureEnabled = false;
                          });
                        }
                      } else {
                        Utils.showTopSnackBar(
                            context, 'Genera una firma', Colors.red);
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _signatureCanvas() {
    return Signature(
      controller: _controller,
      height: 200,
      width: 350,
      backgroundColor: Colors.white60,
    );
  }
}
