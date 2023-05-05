// import 'package:app_ciudadana/src/models/event.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';

// class EditEvent extends StatefulWidget {
//   final String escuelaId;

//   final DateTime firstDate;
//   final DateTime lastDate;
//   final Event event;
//   const EditEvent(
//       {Key? key,
//       required this.firstDate,
//       required this.lastDate,
//       required this.event,
//       required this.escuelaId})
//       : super(key: key);

//   @override
//   State<EditEvent> createState() => _EditEventState();
// }

// class _EditEventState extends State<EditEvent> {
//   final _auth = FirebaseAuth.instance;
//   late DateTime _selectedDate;
//   late TextEditingController _titleController;
//   late TextEditingController _descriptionController;
//   final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = widget.event.date;
//     _titleController = TextEditingController(text: widget.event.title);
//     _descriptionController =
//         TextEditingController(text: widget.event.description);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Edit Event")),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16.0),
//           children: [
//             InputDatePickerFormField(
//               firstDate: widget.firstDate,
//               lastDate: widget.lastDate,
//               initialDate: _selectedDate,
//               onDateSubmitted: (date) {
//                 print(date);
//                 setState(() {
//                   _selectedDate = date;
//                 });
//               },
//             ),
//             // GestureDetector(
//             //   onTap: () {
//             //     _selectDate(context);
//             //   },
//             //   child: Text(
//             //     'Fecha: ${dateFormat.format(_selectedDate)}',
//             //     style: const TextStyle(
//             //       fontWeight: FontWeight.w700,
//             //       fontSize: 17,
//             //     ),
//             //   ),
//             // ),
//             const SizedBox(height: 10),
//             const Text('Titulo'),
//             TextFormField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 hintText: 'Título',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text('Descripción'),
//             TextFormField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(
//                 hintText: 'Descripción',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 5,
//             ),
//             // TextField(
//             //   controller: _titleController,
//             //   maxLines: 1,
//             //   decoration: const InputDecoration(labelText: 'Asunto'),
//             // ),
//             // TextField(
//             //   controller: _descriptionController,
//             //   maxLines: 5,
//             //   decoration: const InputDecoration(labelText: 'Description'),
//             // ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 final currentUser = _auth.currentUser;
//                 if (_formKey.currentState!.validate()) {
//                   // Guarda los nuevos datos de la escuela en la base de datos.
//                   FirebaseFirestore.instance
//                       .collection('usuarios')
//                       .doc(currentUser!.uid)
//                       .collection('events')
//                       .doc(_auth.currentUser!.uid)
//                       .update(
//                     {
//                       // 'puesto': _puestoController.text,
//                       'date': Timestamp.fromDate(_selectedDate),
//                       'title': _titleController.text,
//                       'description': _descriptionController.text,
//                     },
//                   );
//                   Navigator.pop(context);
//                 }
//               },
//               child: const Text("Guardar cambios"),
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all<Color>(const Color(0xff8c6d62)),
//               ),
//             ),
//             // ElevatedButton(
//             //     onPressed: () {
//             //       final currentUser = _auth.currentUser;
//             //       if (_formKey.currentState!.validate()) {
//             //         // Guarda los nuevos datos de la escuela en la base de datos.
//             //         FirebaseFirestore.instance
//             //             .collection('usuarios')
//             //             .doc(currentUser!.uid)
//             //             .collection('events')
//             //             .doc(widget.escuelaId)
//             //             .update(
//             //           {
//             //             // 'puesto': _puestoController.text,
//             //             'date': Timestamp.fromDate(_selectedDate),
//             //             'title': _titleController.text,
//             //             'description': _descriptionController.text,
//             //           },
//             //         );
//             //         Navigator.pop(context);
//             //       }
//             //     },
//             //     child: const Text("Guardar cambios"),
//             //     style: ButtonStyle(
//             //       backgroundColor:
//             //           MaterialStateProperty.all<Color>(const Color(0xff8c6d62)),
//             //     )),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: dateFormat.parse(dateFormat.format(_selectedDate)),
//       firstDate: DateTime(1900),
//       // lastDate: DateTime.now(2100),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null && picked != _selectedDate)
//       setState(() {
//         _selectedDate = picked;
//       });
//     // final eventos = FirebaseFirestore.instance
//     //     // .collection('eventos')
//     //     // .where('fecha', isEqualTo: Timestamp.fromDate(_selectedDate))
//     //     // .snapshots();
//     //     .collection('usuarios')
//     //     .doc(_auth.currentUser!.uid)
//     //     .collection('events')
//     //     .where('date', isGreaterThanOrEqualTo: _selectedDate)
//     //     .where('date', isLessThanOrEqualTo: _selectedDate)
//     //     // .withConverter(
//     //     //   fromFirestore: Event.fromFirestore,
//     //     //   toFirestore: (event, options) => event.toFirestore(),
//     //     // )
//     //     .get();
//   }

//   // void _addEvent() async {
//   //   final title = _titleController.text;
//   //   final description = _descController.text;
//   //   if (title.isEmpty) {
//   //     print('title cannot be empty');
//   //     return;
//   //   }
//   //   await FirebaseFirestore.instance
//   //       .collection('events')
//   //       .doc(widget.event.id)
//   //       .update({
//   //     "title": title,
//   //     "description": description,
//   //     "date": Timestamp.fromDate(_selectedDate),
//   //   });
//   //   if (mounted) {
//   //     Navigator.pop<bool>(context, true);
//   //   }
//   // }
//   void _addEvent() async {
//     final title = _titleController.text;
//     final description = _descriptionController.text;
//     final currentUser = _auth.currentUser;
//     if (title.isEmpty) {
//       print('title cannot be empty');
//       return;
//     }
//     // final adjustedDate = _selectedDate.toLocal();
//     await FirebaseFirestore.instance
//         .collection('usuarios')
//         .doc(currentUser!.uid)
//         .collection('events')
//         .add({
//       "title": title,
//       "description": description,
//       // "date": _selectDate(context),
//       "date": dateFormat.parse(dateFormat.format(_selectedDate)),
//       // Timestamp.fromDate(_selectedDate).toDate(),
//     });
//     if (mounted) {
//       Navigator.pop<bool>(context, true);
//     }
//   }
// }

import 'package:app_ciudadana/src/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditEvent extends StatefulWidget {
  final String? escuelaId;
  final DateTime firstDate;
  final DateTime lastDate;
  final Event event;
  const EditEvent(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      required this.event,
      this.escuelaId})
      : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late DateTime _selectedDate;
  late TextEditingController _titleController;
  late TextEditingController _descController;
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.event.date;
    _titleController = TextEditingController(text: widget.event.title);
    _descController = TextEditingController(text: widget.event.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Event")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            InputDatePickerFormField(
              firstDate: widget.firstDate,
              lastDate: widget.lastDate,
              initialDate: _selectedDate,
              onDateSubmitted: (date) {
                print(date);
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
            TextField(
              controller: _titleController,
              maxLines: 1,
              decoration: const InputDecoration(labelText: 'title'),
            ),
            TextField(
              controller: _descController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'description'),
            ),

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
                      'title': _titleController.text,
                      'description': _descController.text,
                    },
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Guardar cambios"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff8c6d62)),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     _addEvent();
            //   },
            //   child: const Text("guardar"),
            // ),
          ],
        ),
      ),
    );
  }

  void _addEvent() async {
    final title = _titleController.text;
    final description = _descController.text;
    if (title.isEmpty) {
      print('title cannot be empty');
      return;
    }
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('events')
        .doc(_auth.currentUser!.uid)
        .update({
      "title": title,
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
