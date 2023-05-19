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
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _aPaternoController = TextEditingController();

  final TextEditingController _aMaternoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();

  final TextEditingController _calleController = TextEditingController();

  final TextEditingController _numeroController = TextEditingController();

  final TextEditingController _coloniaController = TextEditingController();

  final TextEditingController _codigoPostalController = TextEditingController();

  final TextEditingController _municipioController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String idEscuela;
  _EditEjecucionScreenState({required this.idEscuela});

  @override
  void initState() {
    super.initState();
    _aMaternoController.text =
        widget.data['aMaterno'] != null ? widget.data['aMaterno'] : '';
    _aPaternoController.text = widget.data['aPaterno'] != null
        ? widget.data['aPaterno']
        : 'No hay apellido paterno';
    _calleController.text =
        widget.data['calle'] != null ? widget.data['calle'] : 'No hay calle';
    _codigoPostalController.text = widget.data['codigoPostal'] != null
        ? widget.data['codigoPostal']
        : 'No hay codigo postal';
    _coloniaController.text = widget.data['colonia'] != null
        ? widget.data['colonia']
        : 'No hay colonia';
    _curpController.text =
        widget.data['curp'] != null ? widget.data['curp'] : 'No hay curp';
    _municipioController.text = widget.data['municipio'] != null
        ? widget.data['municipio']
        : 'No hay municipio';
    _nombreController.text =
        widget.data['nombre'] != null ? widget.data['nombre'] : 'No hay nombre';
    _numeroController.text =
        widget.data['numero'] != null ? widget.data['numero'] : 'No hay numero';
    _puestoController.text =
        widget.data['puesto'] != null ? widget.data['puesto'] : 'No hay puesto';
    _telefonoController.text = widget.data['telefono'] != null
        ? widget.data['telefono']
        : 'No hay telefono';

    // _puestoController.text = widget.data['puesto'] ?? '';
    // _nombreController.text = widget.data['nombre'] ?? '';
    // _telefonoController.text = widget.data['telefono'] ?? '';
  }

  @override
  void dispose() {
    _aMaternoController.dispose();
    _aPaternoController.dispose();
    _calleController.dispose();
    _codigoPostalController.dispose();

    _coloniaController.dispose();

    _curpController.dispose();

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
      'aMaterno': _aMaternoController.text,
      'aPaterno': _aPaternoController.text,
      'calle': _calleController.text,
      'codigoPostal': _codigoPostalController.text,
      'colonia': _coloniaController.text,
      'curp': _curpController.text,
      'municipio': _municipioController.text,
      'numero': _numeroController.text,
    });
    // FirebaseFirestore.instance
    //     .collection('usuarios')
    //     .doc(_auth.currentUser!.uid)
    //     .collection('contactos')
    //     .get()
    //     .then((querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     doc.reference.update({
    //       'nombre': _nombreController.text,
    //       'telefono': _telefonoController.text,
    //     });
    //   });
    // });

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

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _nombreController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Ingresa su nombre',
                    ),
                  ),
                ),

                //Editar el nombre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _aPaternoController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Apellido paterno',
                      hintText: 'Ingresa su apellido paterno',
                    ),
                  ),
                ),

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _aMaternoController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Apellido materno',
                      hintText: 'Ingrese su apellido materno',
                    ),
                  ),
                ),

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _telefonoController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Telefono',
                      hintText: 'Ingrese su telefono',
                    ),
                  ),
                ),

                //Editar el telefono
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _curpController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Curp', hintText: 'Ingrese su curp'),
                  ),
                ),

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _calleController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Calle',
                      hintText: 'Ingrese su calle',
                    ),
                  ),
                ),

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _numeroController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Numero',
                      hintText: 'Ingrese su numero',
                    ),
                  ),
                ),

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _coloniaController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Colonia',
                      hintText: 'Ingrese su colonia',
                    ),
                  ),
                ),

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _codigoPostalController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'C.P',
                      hintText: 'Ingresa codigo postal',
                    ),
                  ),
                ),

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _municipioController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Municipio',
                      hintText: 'Ingrese su municipio',
                    ),
                  ),
                ),

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
                          'aMaterno': _aMaternoController.text,
                          'aPaterno': _aPaternoController.text,
                          'calle': _calleController.text,
                          'codigoPostal': _codigoPostalController.text,
                          'colonia': _coloniaController.text,
                          'curp': _curpController.text,
                          'municipio': _municipioController.text,
                          'numero': _numeroController.text,
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
