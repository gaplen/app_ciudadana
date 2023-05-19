// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';

// class AddEvent extends StatefulWidget {
//   final DateTime firstDate;
//   final DateTime lastDate;
//   final DateTime? selectedDate;
//   String idEscuela;

//   AddEvent({
//     Key? key,
//     required this.firstDate,
//     required this.lastDate,
//     this.selectedDate,
//     required this.idEscuela,
//   }) : super(key: key);

//   @override
//   State<AddEvent> createState() => _AddEventState(idEscuela: idEscuela);
// }

// class _AddEventState extends State<AddEvent> {
//   final _auth = FirebaseAuth.instance;
//   // late DateTime _selectedDate;

//   final _nescuelaController = TextEditingController();
//   final _titleController = TextEditingController();
//   final _descController = TextEditingController();

//   final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
//   DateTime _selectedDate = DateTime.now();
//   DateTime day = DateTime.now();
//   DateTime _selectedTime = DateTime.now();
//   final DateFormat timeFormat = DateFormat('HH:mm');

//   String idEscuela;
//   _AddEventState({required this.idEscuela});

//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = widget.selectedDate ?? DateTime.now();
//     _selectedTime = timeFormat.parse(timeFormat.format(_selectedTime));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Nuevo Evento"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 18),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.height * 0.20,
//                   child: GestureDetector(
//                     onTap: () {
//                       _selectTime(context);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 5, horizontal: 12),
//                       child: Row(
//                         children: [
//                           Icon(Icons.access_time, color: Colors.pink.shade600),
//                           const SizedBox(width: 5),
//                           Text(
//                             'Hora: ${timeFormat.format(_selectedTime)}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 17,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     _selectDate(context);
//                   },
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Icon(Icons.calendar_today,
//                               color: Colors.pink.shade600),
//                           const SizedBox(width: 5),
//                           Text(
//                             'Fecha: ${dateFormat.format(_selectedDate)}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 17,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               //Titulo del evento
//               TextField(
//                 controller: _titleController,
//                 maxLines: 1,
//                 decoration: InputDecoration(
//                   labelText: 'Titulo',
//                   hintText: 'Ingresa el nombre del evento',
//                 ),
//               ),

//               const SizedBox(height: 20),

//               //Descripción del evento
//               TextField(
//                 controller: _descController,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                     labelText: 'Descripcion',
//                     hintText: 'Ingresa la descripción del evento'),
//               ),

//               const SizedBox(height: 20),

//               Row(
//                 //Alinear botones al centro
//                 mainAxisAlignment: MainAxisAlignment.center,

//                 children: [
//                   ElevatedButton(
//                     //Estilo/Diseño de boton
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink,
//                       elevation: 0,
//                       shadowColor: Colors.pink.shade900,
//                     ),

//                     onPressed: () {
//                       _addEvent();
//                     },

//                     child: const Text("Guardar"),
//                   ),
//                   const SizedBox(width: 10),
//                   Container(width: 2, color: Colors.black, height: 50),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                       onPressed: () {
//                         // showNotificacion();
//                       },

//                       //Estilo/Diseño de boton
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink,
//                         elevation: 0,
//                         shadowColor: Colors.pink.shade900,
//                       ),
//                       child: const Text('Notificacion')),
//                 ],
//               ),

//               const SizedBox(height: 250),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: dateFormat.parse(dateFormat.format(_selectedDate)),
//       firstDate: dateFormat.parse(dateFormat.format(day)),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null && picked != _selectedDate)
//       setState(() {
//         _selectedDate = picked;
//       });

//     final eventos = FirebaseFirestore.instance
//         .collection('usuarios')
//         .doc(_auth.currentUser!.uid)
//         .collection('escuelas')
//         .doc(idEscuela)
//         .collection('eventos')
//         .where('date', isGreaterThanOrEqualTo: _selectedDate)
//         .where('date', isLessThanOrEqualTo: _selectedDate)
//         .get();
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.fromDateTime(_selectedTime),
//     );
//     if (picked != null) {
//       setState(() {
//         _selectedTime = DateTime(
//           _selectedDate.year,
//           _selectedDate.month,
//           _selectedDate.day,
//           picked.hour,
//           picked.minute,
//         );
//       });
//     }
//   }

//   void _addEvent() async {
//     final title = _titleController.text;
//     final description = _descController.text;
//     final nombre = _nescuelaController.text;
//     final currentUser = _auth.currentUser;

//     if (title.isEmpty) {
//       print('Título no puede estar vacío');
//       return;
//     }

//     await FirebaseFirestore.instance
//         .collection('usuarios')
//         .doc(currentUser!.uid)
//         .collection('escuelas')
//         .doc(idEscuela)
//         .collection('eventos')
//         .add({
//       "title": title,
//       "nescuela": nombre,
//       "description": description,
//       'time': Timestamp.fromDate(_selectedTime).toDate(),
//       "date": dateFormat.parse(dateFormat.format(_selectedDate)),
//     });

//     if (mounted) {
//       CircularProgressIndicator(
//         color: Colors.pink,
//       );
//       Navigator.pop<bool>(context, true);
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  String idEscuela;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;

  AddEvent({
    Key? key,
    required this.idEscuela,
    required this.firstDate,
    required this.lastDate,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState(idEscuela: idEscuela);
}

class _AddEventState extends State<AddEvent> {
  final _auth = FirebaseAuth.instance;
  // late DateTime _selectedDate;

  final _nescuelaController = TextEditingController();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  DateTime day = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  final DateFormat timeFormat = DateFormat('HH:mm');

  String idEscuela;
  _AddEventState({required this.idEscuela});

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
    _selectedTime = timeFormat.parse(timeFormat.format(_selectedTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Evento General"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.20,
                  child: GestureDetector(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.pink.shade600),
                          const SizedBox(width: 5),
                          Text(
                            'Hora: ${timeFormat.format(_selectedTime)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.pink.shade600),
                          const SizedBox(width: 5),
                          Text(
                            'Fecha: ${dateFormat.format(_selectedDate)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //Titulo del evento
              TextField(
                controller: _nescuelaController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Escuela',
                  hintText: 'Ingresa el nombre de la escuela',
                ),
              ),

              const SizedBox(height: 20),

              //Titulo del evento
              TextField(
                controller: _titleController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Titulo',
                  hintText: 'Ingresa el nombre del evento',
                ),
              ),

              const SizedBox(height: 20),

              //Descripción del evento
              TextField(
                controller: _descController,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Descripcion',
                    hintText: 'Ingresa la descripción del evento'),
              ),

              const SizedBox(height: 20),

              Row(
                //Alinear botones al centro
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  ElevatedButton(
                    //Estilo/Diseño de boton
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      elevation: 0,
                      shadowColor: Colors.pink.shade900,
                    ),

                    onPressed: () {
                      _addEvent();
                    },

                    child: const Text("Guardar"),
                  ),
                  const SizedBox(width: 10),
                  Container(width: 2, color: Colors.black, height: 50),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        // showNotificacion();
                      },

                      //Estilo/Diseño de boton
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        elevation: 0,
                        shadowColor: Colors.pink.shade900,
                      ),
                      child: const Text('Notificacion')),
                ],
              ),

              const SizedBox(height: 250),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateFormat.parse(dateFormat.format(_selectedDate)),
      firstDate: dateFormat.parse(dateFormat.format(day)),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }

    final eventos = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('eventos')
        .where('date', isGreaterThanOrEqualTo: _selectedDate)
        .where('date', isLessThanOrEqualTo: _selectedDate)
        .get();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  void _addEvent() async {
    final title = _titleController.text;
    final description = _descController.text;
    final nombre = _nescuelaController.text;
    final currentUser = _auth.currentUser;

    if (title.isEmpty) {
      print('Título no puede estar vacío');
      return;
    }

    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(currentUser!.uid)
        .collection('escuelas')
        .doc(idEscuela)
        .collection('eventos')
        .add({
      "title": title,
      "nescuela": nombre,
      "description": description,
      'time': Timestamp.fromDate(_selectedTime).toDate(),
      "date": dateFormat.parse(dateFormat.format(_selectedDate)),
    });

    if (mounted) {
      CircularProgressIndicator(
        color: Colors.pink,
      );
      Navigator.pop<bool>(context, true);
    }
  }
}
