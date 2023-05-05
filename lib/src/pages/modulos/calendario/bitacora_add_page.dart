// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';

// class BitacoraAddPage extends StatefulWidget {
//   const BitacoraAddPage({super.key});

//   @override
//   State<BitacoraAddPage> createState() => _BitacoraAddPageState();
// }

// class _BitacoraAddPageState extends State<BitacoraAddPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _dateFormat = DateFormat('dd/MM/yyyy');
//   DateTime _selectedDate = DateTime.now();
//   String? title;
//   String? fecha;
//   String? descripcion;
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: _selectedDate,
//         firstDate: DateTime(1900),
//         lastDate: DateTime.now());

//     if (picked != null && picked != _selectedDate)
//       setState(() {
//         _selectedDate = picked;
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentDate = DateTime.now();
//     final currentDateString = _dateFormat.format(currentDate);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('bitacora add'),
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Text('Fecha: $currentDateString',
//                     style: const TextStyle(fontSize: 16)),
//                 TextField(
//                   keyboardType: TextInputType.emailAddress,
//                   onChanged: (value) {
//                     title = value;
//                   },
//                   decoration: const InputDecoration(
//                     hintText: 'Introduzca asunto',
//                   ),
//                 ),
//                 TextField(
//                   onChanged: (value) {
//                     descripcion = value;
//                   },
//                   decoration: const InputDecoration(
//                     hintText: 'Introduzca una descripcion',
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       final user = await _auth.currentUser;
//                       if (user != null) {
//                         final data = {
//                           'date': FieldValue.serverTimestamp(),
//                           'title': title,
//                           'description': descripcion,
//                         };

//                         await _firestore
//                             .collection('usuarios')
//                             .doc(user.uid)
//                             .collection('events')
//                             .add(data);
//                         Navigator.pop(context);

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Formulario agregado correctamente'),
//                           ),
//                         );
//                       }
//                     } catch (e) {
//                       print(e);
//                     }
//                   },
//                   child: const Text('Agregar usuario'),
//                 ),
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
import 'package:intl/intl.dart';

class BitacoraAddPage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String escuelaId;

  BitacoraAddPage({required this.data, required this.escuelaId});

  @override
  _BitacoraAddPageState createState() => _BitacoraAddPageState();
}

class _BitacoraAddPageState extends State<BitacoraAddPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    titleController.text =
        widget.data['title'] != null ? widget.data['title'] : 'No hay titulo';
    descriptionController.text = widget.data['description'] != null
        ? widget.data['description']
        : 'No hay descripcion';
    final lastDate = DateTime.now() != null ? DateTime.now() : DateTime.now();
    // final date =
    //     DateTime.fromMillisecondsSinceEpoch(widget.data['date'].seconds * 1000);
    // _selectedDate = date.isAfter(lastDate) ? lastDate : date;
    // _selectedDate =
    final date =
        DateTime.fromMillisecondsSinceEpoch(widget.data['date'].seconds * 1000);
  }

  @override
  Widget build(BuildContext context) {
    final date =
        DateTime.fromMillisecondsSinceEpoch(widget.data['date'].seconds * 1000);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff59554e),
        title: const Text('Editar evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(width: 10),
                      Text(
                        'Fecha: ${dateFormat.format(date)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Titulo'),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Descripción'),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      final currentUser = _auth.currentUser;
                      if (_formKey.currentState!.validate()) {
                        // Guarda los nuevos datos de la escuela en la base de datos.
                        FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(currentUser!.uid)
                            .collection('events')
                            .doc(widget.escuelaId)
                            .update(
                          {
                            // 'puesto': _puestoController.text,
                            'date': Timestamp.fromDate(_selectedDate),
                            'title': titleController.text,
                            'description': descriptionController.text,
                          },
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Guardar cambios"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff8c6d62)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateFormat.parse(dateFormat.format(_selectedDate)),
      firstDate: DateTime(1900),
      // lastDate: DateTime.now(2100),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
    final eventos = FirebaseFirestore.instance
        // .collection('eventos')
        // .where('fecha', isEqualTo: Timestamp.fromDate(_selectedDate))
        // .snapshots();
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: _selectedDate)
        .where('date', isLessThanOrEqualTo: _selectedDate)
        // .withConverter(
        //   fromFirestore: Event.fromFirestore,
        //   toFirestore: (event, options) => event.toFirestore(),
        // )
        .get();
  }
}
