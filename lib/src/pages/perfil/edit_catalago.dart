import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditarCatalago extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String escuelaId;

  const EditarCatalago({required this.data, required this.escuelaId});

  @override
  _EditarCatalagoState createState() => _EditarCatalagoState();
}

class _EditarCatalagoState extends State<EditarCatalago> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _nombreController.text =
        widget.data['nombre'] != null ? widget.data['nombre'] : 'No hay nombre';
  }

  @override
  void dispose() {
    _nombreController.dispose();

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
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      labelText: "Nombre de la escuela",
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
                            .collection('etiquetas')
                            .doc(widget.escuelaId)
                            .update(
                          {
                            'nombre': _nombreController.text,
                          },
                        );

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
