// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class EditEjecucionScreen extends StatefulWidget {
//   final QueryDocumentSnapshot<Map<String, dynamic>> data;
//   final String escuelaId;

//   const EditEjecucionScreen({required this.data, required this.escuelaId});

//   @override
//   _EditEjecucionScreenState createState() => _EditEjecucionScreenState();
// }

// class _EditEjecucionScreenState extends State<EditEjecucionScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _puestoController = TextEditingController();
//   // final TextEditingController _nivelController = TextEditingController();
//   final TextEditingController _nombreController = TextEditingController();
//   final TextEditingController _telefonoController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;

//   @override
//   void initState() {
//     super.initState();
//     _puestoController.text =
//         widget.data['puesto'] != null ? widget.data['puesto'] : 'No hay puesto';
//     _nombreController.text =
//         widget.data['nombre'] != null ? widget.data['nombre'] : 'No hay nombre';
//     // _nombreContactoController.text = widget.data['nombreContacto'];
//     _telefonoController.text = widget.data['telefono'] != null
//         ? widget.data['telefono']
//         : 'No hay telefono';
//   }

//   @override
//   void dispose() {
//     _puestoController.dispose();
//     _nombreController.dispose();
//     // _nombreContactoController.dispose();
//     _telefonoController.dispose();
//     super.dispose();
//   }

//   void _updateData(String currentUser) async {
//     await FirebaseFirestore.instance
//         .collection('comiteEjecucion')
//         .doc(_auth.currentUser!.uid)
//         .update({
//       'puesto': _puestoController.text,
//       'nombre': _nombreController.text,
//       // 'nombreContacto': _nombreContactoController.text,
//       'telefono': _telefonoController.text,
//     });

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Editar ejecucion"),
//         backgroundColor: Color(0xff59554e),
//       ),
//       body: Container(
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xffa1c1be), Color(0xff9ec4bb), Color(0xffeed7c5)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _puestoController,
//                     decoration: const InputDecoration(
//                       labelText: "Puesto",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _nombreController,
//                     decoration: const InputDecoration(
//                       labelText: "Nombre",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _telefonoController,
//                     decoration: const InputDecoration(
//                       labelText: "Telefono",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 15),
//                 //   child: TextFormField(
//                 //     controller: _telefonoController,
//                 //     decoration: const InputDecoration(
//                 //       labelText: "Teléfono",
//                 //     ),
//                 //   ),
//                 // ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                     onPressed: () {
//                       final currentUser = _auth.currentUser;
//                       if (_formKey.currentState!.validate()) {
//                         // Guarda los nuevos datos de la escuela en la base de datos.
//                         FirebaseFirestore.instance
//                             .collection('usuarios')
//                             .doc(currentUser!.uid)
//                             .collection('comiteEjecucion')
//                             .doc(widget.escuelaId)
//                             .update(
//                           {
//                             'puesto': _puestoController.text,
//                             'nombre': _nombreController.text,
//                             'telefono': _telefonoController.text,
//                           },
//                         );
//                         Navigator.pop(context);
//                       }
//                     },
//                     child: const Text("Guardar cambios"),
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(Color(0xff8c6d62)),
//                     )),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditEjecucionScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String idEjecucion;
  String idEscuela;

  EditEjecucionScreen(
      {super.key,
      required this.data,
      required this.idEjecucion,
      required this.idEscuela});

  @override
  _EditEjecucionScreenState createState() =>
      _EditEjecucionScreenState(idEscuela: idEscuela);
}

class _EditEjecucionScreenState extends State<EditEjecucionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _puestoController = TextEditingController();
  // final TextEditingController _nivelController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String idEscuela;
  _EditEjecucionScreenState({required this.idEscuela});

  @override
  void initState() {
    super.initState();
    _puestoController.text = widget.data['puesto'] ?? '';
    _nombreController.text = widget.data['nombre'] ?? '';
    _telefonoController.text = widget.data['telefono'] ?? '';
  }

  @override
  void dispose() {
    _puestoController.dispose();
    _nombreController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  void _updateData(String currentUser) async {
    await FirebaseFirestore.instance
        .collection('comiteEjecucion')
        .doc(_auth.currentUser!.uid)
        .update({
      'puesto': _puestoController.text,
      'nombre': _nombreController.text,
      'telefono': _telefonoController.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Datos"),
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _puestoController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Puesto',
                      hintText: 'Ingresa el nuevo puesto',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el nombre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _nombreController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Ingresa le nuevo nombre',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el telefono
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _telefonoController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Teléfono',
                        hintText: 'Ingresa el nuevo teléfono'),
                  ),
                ),

                const SizedBox(height: 40),

                //Boton guardar cambios
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
                          .collection('comiteEjecucion')
                          .doc(widget.idEjecucion)
                          .update(
                        {
                          'puesto': _puestoController.text,
                          'nombre': _nombreController.text,
                          'telefono': _telefonoController.text,
                        },
                      );
                      Navigator.pop(context);
                    }
                  },

                  //Estilo/Diseño de boton
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    elevation: 0,
                    shadowColor: Colors.pink.shade900,
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
