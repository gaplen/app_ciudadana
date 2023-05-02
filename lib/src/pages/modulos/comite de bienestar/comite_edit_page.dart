// // // import 'package:flutter/material.dart';

// // // class EditBienestarPage extends StatefulWidget {
// // //   const EditBienestarPage({super.key});

// // //   @override
// // //   State<EditBienestarPage> createState() => _EditBienestarPageState();
// // // }

// // // class _EditBienestarPageState extends State<EditBienestarPage> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('edit comite bienestar'),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';

// // class EditarComiteBienestarPage extends StatefulWidget {
// //   const EditarComiteBienestarPage({Key? key}) : super(key: key);

// //   @override
// //   _EditarComiteBienestarPageState createState() =>
// //       _EditarComiteBienestarPageState();
// // }

// // class _EditarComiteBienestarPageState extends State<EditarComiteBienestarPage> {
// //   late String puesto;
// //   late String nombre;
// //   late String aPaterno;
// //   late String aMaterno;
// //   late String telefono;
// //   late String curp;
// //   late String calle;
// //   late String numero;
// //   late String colonia;
// //   late String codigoPostal;
// //   late String municipio;

// //   @override
// //   void initState() {
// //     super.initState();

// //     final Map<String, dynamic> arguments =
// //         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

// //     puesto = arguments['puesto'] ?? '';
// //     nombre = arguments['nombre'] ?? '';
// //     aPaterno = arguments['aPaterno'] ?? '';
// //     aMaterno = arguments['aMaterno'] ?? '';

// //     telefono = arguments['telefono'] ?? '';
// //     curp = arguments['curp'] ?? '';
// //     calle = arguments['calle'] ?? '';
// //     numero = arguments['numero'] ?? '';
// //     colonia = arguments['colonia'] ?? '';
// //     codigoPostal = arguments['codigoPostal'] ?? '';
// //     municipio = arguments['municipio'] ?? '';
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ComiteEditPage extends StatefulWidget {
//   final DocumentSnapshot user;

//   const ComiteEditPage({required this.user});

//   @override
//   _ComiteEditPageState createState() => _ComiteEditPageState();
// }

// class _ComiteEditPageState extends State<ComiteEditPage> {
//   final _formKey = GlobalKey<FormState>();

//   late String _puesto;
//   late String _nombre;

//   @override
//   void initState() {
//     super.initState();
//     _puesto = widget.user['puesto'];
//     _nombre = widget.user['nombre'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Editar usuario'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 initialValue: _puesto,
//                 decoration: const InputDecoration(
//                   labelText: 'Puesto',
//                 ),
//                 onChanged: (value) {
//                   _puesto = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Por favor, introduzca el puesto';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: _nombre,
//                 decoration: const InputDecoration(
//                   labelText: 'Nombre',
//                 ),
//                 onChanged: (value) {
//                   _nombre = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Por favor, introduzca el nombre';
//                   }
//                   return null;
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     try {
//                       final user = FirebaseAuth.instance.currentUser;
//                       if (user != null) {
//                         final data = {
//                           'fecha': FieldValue.serverTimestamp(),
//                           'puesto': _puesto,
//                           'nombre': _nombre,
//                         };
//                         await FirebaseFirestore.instance
//                             .collection('usuarios')
//                             .doc(user.uid)
//                             .collection('comiteBienestar')
//                             .doc(widget.user.id)
//                             .update(data);
//                         Navigator.of(context).pop();
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Usuario editado correctamente'),
//                           ),
//                         );
//                       }
//                     } catch (e) {
//                       print(e);
//                     }
//                   }
//                 },
//                 child: const Text('Guardar cambios'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditarComiteBienestarPage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>? comiteBienestar;

  const EditarComiteBienestarPage(
      {super.key,
      QueryDocumentSnapshot<Map<String, dynamic>>? data,
      this.comiteBienestar});

  @override
  _EditarComiteBienestarPageState createState() =>
      _EditarComiteBienestarPageState();
}

class _EditarComiteBienestarPageState extends State<EditarComiteBienestarPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _aPaternoController = TextEditingController();
  final _aMaternoController = TextEditingController();
  final _telefonoController = TextEditingController();

  bool _guardando = false;

  @override
  void initState() {
    super.initState();

    final data = widget.comiteBienestar?.data();
    _nombreController.text = data?['nombre'] as String;
    _aPaternoController.text = data?['aPaterno'] as String;
    _aMaternoController.text = data?['aMaterno'] as String;
    _telefonoController.text = data?['telefono'] as String;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _aPaternoController.dispose();
    _aMaternoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  Future<void> _guardarCambios() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _guardando = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    final comiteRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user!.uid)
        .collection('comiteBienestar');
    final newData = {
      'nombre': _nombreController.text.trim(),
      'aPaterno': _aPaternoController.text.trim(),
      'aMaterno': _aMaternoController.text.trim(),
      'telefono': _telefonoController.text.trim(),
    };

    try {
      await comiteRef.doc(widget.comiteBienestar?.id).update(newData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cambios guardados')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar cambios')),
      );
    } finally {
      setState(() {
        _guardando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar miembro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aPaternoController,
                decoration: InputDecoration(labelText: 'Apellido paterno'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el apellido paterno';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aMaternoController,
                decoration: InputDecoration(labelText: 'Apellido materno'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el apellido materno';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _guardando ? null : _guardarCambios,
                child: _guardando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
