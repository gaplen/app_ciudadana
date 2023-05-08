import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FichaTecnicaRegistro extends StatefulWidget {
  const FichaTecnicaRegistro({super.key});

  @override
  _FichaTecnicaRegistroState createState() => _FichaTecnicaRegistroState();
}

class _FichaTecnicaRegistroState extends State<FichaTecnicaRegistro> {
  final _formKey = GlobalKey<FormState>();
  String? nivel;
  String? matricula;
  String? nombre;
  String? telefono;
  String? numCTT;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  List<String> ctt = [
    'CTT1',
    'CTT2',
    'CTT3',
    'CTT4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff59554e),
          title: const Text('Registro CTT')),
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
                      hintText: 'Seleccionar CTT',
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
                      numCTT = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Introduzca su CTT',
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
                      nombre = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Nombre',
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
                    onChanged: (value) {
                      telefono = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Telefono',
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
                    onChanged: (value) {
                      matricula = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Matricula',
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
                            'nombre': nombre,
                            'telefono': telefono,
                            'nivel': nivel,
                            'numCTT': numCTT,
                            'matricula': matricula,
                          };

                          await _firestore
                              .collection('usuarios')
                              .doc(user.uid)
                              .collection('bienestarCTT')
                              .doc() // Puedes pasar un ID como argumento si deseas definir uno manualmente
                              .set(data);

                          // await _firestore
                          //     .collection('usuarios')
                          //     .doc(user.uid)
                          //     .collection('bienestarCTT')
                          //     .add(data);
                          Navigator.pop(context);

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
                    child: const Text('Agregar'),
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
