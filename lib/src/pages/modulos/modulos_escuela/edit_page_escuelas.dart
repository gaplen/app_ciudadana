// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class EditEscuelaScreen extends StatefulWidget {
//   final String escuelaId;

//   const EditEscuelaScreen(
//       {Key? key,
//       required this.escuelaId,
//       required QueryDocumentSnapshot<Map<String, dynamic>> data})
//       : super(key: key);

//   @override
//   _EditEscuelaScreenState createState() => _EditEscuelaScreenState();
// }

// class _EditEscuelaScreenState extends State<EditEscuelaScreen> {
//   final _nombreController = TextEditingController();
//   final _nivelController = TextEditingController();
//   final _nombreContactoController = TextEditingController();
//   final _telefonoController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadEscuelaData();
//   }

//   // void _loadEscuelaData() async {
//   //   final snapshot =
//   //       await FirebaseFirestore.instance.collection('escuelas').doc(widget.data.id).get();
//   //   final data = snapshot.data();
//   //   _nombreController.text = data?['nombreEscuela'] ?? '';
//   //   _nivelController.text = data?['nivel'] ?? '';
//   //   _nombreContactoController.text = data?['nombreContacto'] ?? '';
//   //   _telefonoController.text = data?['telefono'] ?? '';
//   // }
//   void _loadEscuelaData() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('escuelas')
//         .doc(widget.escuelaId) // Utilizar el ID del documento
//         .get();
//     final data = snapshot.data();
//     _nombreController.text = data?['nombreEscuela'] ?? '';
//     _nivelController.text = data?['nivel'] ?? '';
//     _nombreContactoController.text = data?['nombreContacto'] ?? '';
//     _telefonoController.text = data?['telefono'] ?? '';
//   }

//   void _saveChanges() async {
//     await FirebaseFirestore.instance
//         .collection('usuarios')
//         .doc(widget.escuelaId)
//         .update({
//       'nombreEscuela': _nombreController.text,
//       'nivel': _nivelController.text,
//       'nombreContacto': _nombreContactoController.text,
//       'telefono': _telefonoController.text,
//     });

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Editar escuela'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _nombreController,
//               decoration: const InputDecoration(
//                 labelText: 'Nombre de la escuela',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             TextFormField(
//               controller: _nivelController,
//               decoration: const InputDecoration(
//                 labelText: 'Nivel',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             TextFormField(
//               controller: _nombreContactoController,
//               decoration: const InputDecoration(
//                 labelText: 'Nombre de contacto',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             TextFormField(
//               controller: _telefonoController,
//               decoration: const InputDecoration(
//                 labelText: 'Teléfono',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _saveChanges,
//               child: const Text('Guardar cambios'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:app_ciudadana/src/pages/modulos/escuelas_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/edit_page_escuelas.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/modulos_page.dart';
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
    _nombreEscuelaController.text = widget.data['nombreEscuela'];
    _nivelController.text = widget.data['nivel'];
    _nombreContactoController.text = widget.data['nombreContacto'];
    _telefonoController.text = widget.data['telefono'];
  }

  @override
  void dispose() {
    _nombreEscuelaController.dispose();
    _nivelController.dispose();
    _nombreContactoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  void _updateData(String documentId) async {
    await FirebaseFirestore.instance
        .collection('escuelas')
        .doc(documentId)
        .update({
      'nombreEscuela': _nombreEscuelaController.text,
      'nivel': _nivelController.text,
      'nombreContacto': _nombreContactoController.text,
      'telefono': _telefonoController.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Escuela"),
      ),
      body: SingleChildScrollView(
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
                controller: _nombreContactoController,
                decoration: const InputDecoration(
                  labelText: "Nombre del contacto",
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
                _updateData(widget.escuelaId);
              },
              child: const Text("Guardar cambios"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EscuelasScreen(),
                  ),
                );
              },
              child: const Text("Ir a módulos"),
            ),
          ],
        ),
      ),
    );
  }
}
