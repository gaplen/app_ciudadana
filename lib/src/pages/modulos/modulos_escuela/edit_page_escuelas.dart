import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditEscuelaScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String escuelaId;

  const EditEscuelaScreen({required this.data, required this.escuelaId});

  @override
  _EditEscuelaScreenState createState() => _EditEscuelaScreenState();
}

class _EditEscuelaScreenState extends State<EditEscuelaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreEscuelaController =
      TextEditingController();
  final TextEditingController _nivelController = TextEditingController();
  final TextEditingController _nombreContactoController =
      TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _nombreEscuelaController.text = widget.data['nombreEscuela'] != null
        ? widget.data['nombreEscuela']
        : 'No hay nombre';
    _nivelController.text =
        widget.data['nivel'] != null ? widget.data['nivel'] : 'No hay nivel';
    // _nombreContactoController.text = widget.data['nombreContacto'];
    _telefonoController.text = widget.data['telefono'] != null
        ? widget.data['telefono']
        : 'No hay telefono';
  }

  @override
  void dispose() {
    _nombreEscuelaController.dispose();
    _nivelController.dispose();
    // _nombreContactoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Escuela"),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _nombreEscuelaController,
                    decoration: const InputDecoration(
                      labelText: "Nombre de la escuela",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _nivelController,
                    decoration: const InputDecoration(
                      labelText: "Nivel",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _telefonoController,
                    decoration: const InputDecoration(
                      labelText: "Teléfono",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      final currentUser = _auth.currentUser;
                      if (_formKey.currentState!.validate()) {
                        // Guarda los nuevos datos de la escuela en la base de datos.
                        FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(currentUser!.uid)
                            .collection('escuelas')
                            .doc(widget.escuelaId)
                            .update(
                          {
                            'nombreEscuela': _nombreEscuelaController.text,
                            'nivel': _nivelController.text,
                            'telefono': _telefonoController.text,
                          },
                        );
                        FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(currentUser.uid)
                            .collection('contactos')
                            // .where('userId', isEqualTo: currentUser.uid)
                            // .where('escuelaId', isEqualTo: widget.escuelaId)
                            .get()
                            .then((querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            doc.reference.update({
                              'telefono': _telefonoController.text,
                            });
                          });
                        });

                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Guardar cambios"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff8c6d62)),
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
