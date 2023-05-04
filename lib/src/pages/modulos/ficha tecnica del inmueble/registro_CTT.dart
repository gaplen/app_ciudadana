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
      appBar: AppBar(title: const Text('Registro CTT')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
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
                decoration: const InputDecoration(
                  hintText: 'Seleccione el nivel escolar',
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
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  numCTT = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su CTT',
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
                  matricula = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduzca su Matricula',
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
