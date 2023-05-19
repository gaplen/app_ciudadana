import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditEspeciales extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String idEspecial;
  String idEscuela;

  EditEspeciales(
      {required this.data, required this.idEspecial, required this.idEscuela});

  @override
  _EditEspecialesState createState() =>
      _EditEspecialesState(idEscuela: idEscuela);
}

class _EditEspecialesState extends State<EditEspeciales> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String idEscuela;
  _EditEspecialesState({required this.idEscuela});

  @override
  void initState() {
    super.initState();
    _nombreController.text = widget.data['nombre'] ?? '';
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
        title: const Text("Editar Datos"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
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
                    decoration: InputDecoration(
                        labelText: 'Título',
                        hintText: 'Ingresa el nombre de la nueva etiqueta'),
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
                          .doc(idEscuela)
                          .collection('especiales')
                          .doc(widget.idEspecial)
                          .update(
                        {
                          'nombre': _nombreController.text,
                        },
                      );

                      Navigator.pop(context);
                    }
                  },

                  //Estilo/Diseño de boton
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    elevation: 0,
                    shadowColor: Colors.pink.shade800,
                  ),

                  child: const Text("Guardar cambios"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
