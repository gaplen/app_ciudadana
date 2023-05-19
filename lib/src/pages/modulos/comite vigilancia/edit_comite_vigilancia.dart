// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class EditVigilanciaScreen extends StatefulWidget {
//   final QueryDocumentSnapshot<Map<String, dynamic>> data;
//   final String escuelaId;

//   const EditVigilanciaScreen({required this.data, required this.escuelaId});

//   @override
//   _EditVigilanciaScreenState createState() => _EditVigilanciaScreenState();
// }

// class _EditVigilanciaScreenState extends State<EditVigilanciaScreen> {
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
//         .collection('comiteVigilancia')
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
//                             .collection('comiteVigilancia')
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

class EditVigilanciaScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String idVigilancia;
  String idEscuela;

  EditVigilanciaScreen(
      {required this.data,
      required this.idVigilancia,
      required this.idEscuela});

  @override
  _EditVigilanciaScreenState createState() =>
      _EditVigilanciaScreenState(idEscuela: idEscuela);
}

class _EditVigilanciaScreenState extends State<EditVigilanciaScreen> {
  final _formKey = GlobalKey<FormState>();

  //Variables para editar datos
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apaternoController = TextEditingController();
  final TextEditingController _amaternoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _coloniaController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _municipioController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String idEscuela;
  _EditVigilanciaScreenState({required this.idEscuela});

  @override
  void initState() {
    super.initState();
    _puestoController.text = widget.data['puesto'] ?? '';
    _nombreController.text = widget.data['nombre'] ?? '';
    _apaternoController.text = widget.data['aPaterno'] ?? '';
    _amaternoController.text = widget.data['aMaterno'] ?? '';
    _telefonoController.text = widget.data['telefono'] ?? '';
    _curpController.text = widget.data['curp'] ?? '';
    _calleController.text = widget.data['calle'] ?? '';
    _numeroController.text = widget.data['numero'] ?? '';
    _coloniaController.text = widget.data['colonia'] ?? '';
    _cpController.text = widget.data['codigoPostal'] ?? '';
    _municipioController.text = widget.data['municipio'] ?? '';
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
        .collection('comiteVigilancia')
        .doc(_auth.currentUser!.uid)
        .update({
      'puesto': _puestoController.text,
      'nombre': _nombreController.text,
      'aPaterno': _apaternoController.text,
      'aMaterno': _amaternoController.text,
      'telefono': _telefonoController.text,
      'curp': _curpController.text,
      'calle': _calleController.text,
      'numero': _numeroController.text,
      'colonia': _coloniaController.text,
      'codigoPostal': _cpController.text,
      'municipio': _municipioController.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Datos'),
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
                const Text('Datos personales',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                //Editar puesto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _puestoController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Puesto',
                        hintText: 'Ingresa el nuevo puesto'),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar nombre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _nombreController,
                    //Diselo del input
                    decoration: InputDecoration(
                        labelText: 'Nombre',
                        hintText: 'Ingresa el nuevo nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce tu nombre';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el apellido paterno
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _apaternoController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Apellido Paterno',
                      hintText: 'Ingresa el nuevo apellido',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el apellido materno
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _amaternoController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Apellido Materno',
                      hintText: 'Ingresa el nuevo apellido',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el teléfono
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _telefonoController,
                    //teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Telefono',
                      hintText: 'Ingresa el nuevo teléfono',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar la CURP
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _curpController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'CURP',
                      hintText: 'Ingresa la nueva CURP',
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Text('Domicilio',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                //Editar la calle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _calleController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Calle',
                      hintText: 'Ingresa la nueva calle',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar numero de casa
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _numeroController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Número',
                      hintText: 'Ingresa el nuevo número',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar la colonia
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _coloniaController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Colonia',
                      hintText: 'Ingresa la nueva colonia',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el Codigo postal
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _cpController,
                    //Teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Código Postal',
                      hintText: 'Ingresa el nuevo código postal',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el municipio
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _municipioController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Alcaldia / Municipio',
                      hintText: 'Ingresa el nuevo municipio',
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                //Boton para guardar cambios
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
                          .collection('comiteVigilancia')
                          .doc(widget.idVigilancia)
                          .update(
                        {
                          'puesto': _puestoController.text,
                          'nombre': _nombreController.text,
                          'aPaterno': _apaternoController.text,
                          'aMaterno': _amaternoController.text,
                          'telefono': _telefonoController.text,
                          'curp': _curpController.text,
                          'calle': _calleController.text,
                          'numero': _numeroController.text,
                          'colonia': _coloniaController.text,
                          'codigoPostal': _cpController.text,
                          'municipio': _municipioController.text,
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
