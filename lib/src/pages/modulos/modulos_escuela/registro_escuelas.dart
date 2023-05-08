import 'dart:typed_data';

import 'package:app_ciudadana/src/utils/internet_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class RegistroEscuela extends StatefulWidget {
  const RegistroEscuela({super.key});

  @override
  _RegistroEscuelaState createState() => _RegistroEscuelaState();
}

Uint8List? image;
// Color inicial del botón

class _RegistroEscuelaState extends State<RegistroEscuela> {
  bool isSignatureEnabled = true;
  bool _isButtonEnabled = true;
  Color _buttonColor = Colors.green; //
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
  final GlobalKey<SfSignaturePadState> _signaturePadKey =
      GlobalKey<SfSignaturePadState>();

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white10,
  );

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
        title: const Text('Registro de Escuela'),
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
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Por favor, selecciona el nivel escolar';
                      // }
                      // return null;
                    },
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
                  child: TextFormField(
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
                    keyboardType: TextInputType.number,
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
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    // validator: (value) {
                    //   if (value == null ||
                    //       value.isEmpty ||
                    //       value.length < 10 ||
                    //       value.length > 10) {
                    //     return 'Por favor, introduce un numero valido';
                    //   }
                    //   return null;
                    // },
                    onChanged: (value) {
                      telefono = value;
                    },
                    decoration: InputDecoration(
                      hintMaxLines: 10,
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
                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0),
                //   child: const Text(
                //     'Ingrese su firma',
                //     style: TextStyle(fontSize: 15),
                //   ),
                // ),

                // _signature(Colors.white),
                // const SizedBox(height: 30),
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
                          };
                          await _firestore
                              .collection('usuarios')
                              .doc(user.uid)
                              .collection('contactos')
                              .add(data2);
                          Navigator.pop(context);
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //       builder: (_) => const EscuelasScreen()),
                          // );
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
                  child: const Text('Agregar escuela'),
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
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      decoration: BoxDecoration(
        color: colorPrimario,
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
