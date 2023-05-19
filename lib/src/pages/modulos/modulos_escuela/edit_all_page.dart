// import 'package:app_ciudadana/src/pages/modulos/calendario/bitacora_page.dart';
// import 'package:app_ciudadana/src/pages/modulos/calendario/calendario_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';

// class EditAllSchool extends StatefulWidget {
//   final QueryDocumentSnapshot<Map<String, dynamic>> data;
//   final String escuelaId;
//   final DateTime? selectedDate;

//   const EditAllSchool(
//       {required this.data, required this.escuelaId, this.selectedDate});

//   @override
//   _EditAllSchoolState createState() => _EditAllSchoolState();
// }

// class _EditAllSchoolState extends State<EditAllSchool> {
//   List<DropdownMenuItem<String>> _dropdownItems = [];
//   final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
//   DateTime _selectedDate = DateTime.now();
//   DateTime day = DateTime.now();
//   DateTime _selectedTime = DateTime.now();
//   final DateFormat timeFormat = DateFormat('HH:mm');
//   // final QueryDocumentSnapshot<Map<String, dynamic>> data;
//   // _EditAllSchoolState({required this.data});

//   late String _selectedItem;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _cttController = TextEditingController();
//   final TextEditingController _nombreEscuelaController =
//       TextEditingController();
//   final TextEditingController _nivelController = TextEditingController();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descripcionController = TextEditingController();
//   final TextEditingController _turnoController = TextEditingController();
//   final TextEditingController _calleController = TextEditingController();
//   final TextEditingController _coloniaController = TextEditingController();
//   final TextEditingController _numeroController = TextEditingController();
//   final TextEditingController _municipioController = TextEditingController();
//   final TextEditingController _cpController = TextEditingController();
//   final TextEditingController _nombreContactoController =
//       TextEditingController();
//   final TextEditingController _apellidoContatoController =
//       TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _telefonoController = TextEditingController();

//   final TextEditingController _etiquetaController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   String? _selectedValue;

//   List<String> _turnoOptions = ['Mañana', 'Tarde', 'Noche'];

//   @override
//   void initState() {
//     super.initState();
//     _selectedValue = widget.data['etiqueta'] ?? _selectedValue;
//     String _selectedTurno = widget.data['turno'] ?? _turnoOptions[0];

//     _cttController.text =
//         widget.data['ctt'] != null ? widget.data['ctt'] : 'No hay ctt';

//     _nombreEscuelaController.text = widget.data['nombreEscuela'] != null
//         ? widget.data['nombreEscuela']
//         : 'No hay nombre';
//     _nivelController.text =
//         widget.data['nivel'] != null ? widget.data['nivel'] : 'No hay nivel';

//     _turnoController.text = widget.data['turno'] != null
//         ? widget.data['turno']
//         : 'No hay informacion';

//     _calleController.text =
//         widget.data['calle'] != null ? widget.data['calle'] : 'No hay nombre';

//     _coloniaController.text = widget.data['colonia'] != null
//         ? widget.data['colonia']
//         : 'No hay nombre';

//     _numeroController.text = widget.data['numero'] != null
//         ? widget.data['nombreEscuela']
//         : 'No hay nombre';

//     _municipioController.text = widget.data['municipio'] != null
//         ? widget.data['municipio']
//         : 'No hay nombre';
//     _cpController.text = widget.data['codigoPostal'] != null
//         ? widget.data['codigoPostal']
//         : 'No hay nombre';

//     _nombreContactoController.text = widget.data['nombreContacto'] != null
//         ? widget.data['nombreContacto']
//         : 'No hay informacion';
//     _apellidoContatoController.text = widget.data['nombreContacto'] != null
//         ? widget.data['nombreContacto']
//         : 'No hay informacion';
//     _emailController.text = widget.data['correoElectronico'] != null
//         ? widget.data['correoElectronico']
//         : 'No hay i';
//     // _nombreContactoController.text = widget.data['nombreContacto'];
//     _telefonoController.text =
//         widget.data['telefono'] != null ? widget.data['telefono'] : 'No hay i';
//     _etiquetaController.text =
//         widget.data['etiqueta'] != null ? widget.data['etiqueta'] : '';
//     _selectedDate = widget.selectedDate ?? DateTime.now();
//     _selectedTime = timeFormat.parse(timeFormat.format(_selectedTime));
//   }

//   @override
//   void dispose() {
//     _nombreEscuelaController.dispose();
//     _nivelController.dispose();
//     // _nombreContactoController.dispose();
//     _telefonoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Editar Escuela"),
//         backgroundColor: Color(0xff59554e),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 MaterialPageRoute(
//                   builder: (_) => CalendarioPage(
//                     idEscuela: '',
//                   ),
//                 );
//               },
//               icon: Icon(Icons.calendar_month)),
//         ],
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
//               children: [
//                 StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                   stream: _auth.currentUser != null
//                       ? FirebaseFirestore.instance
//                           .collection('usuarios')
//                           .doc(_auth.currentUser!.uid)
//                           .collection('etiquetas')
//                           // .where('nombre', isGreaterThanOrEqualTo: _searchText)
//                           // .where('nombre', isLessThanOrEqualTo: _searchText + '\uf8ff')
//                           .snapshots()
//                       : const Stream.empty(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                           snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return const Center(child: Text("Error"));
//                     } else {
//                       final docs = snapshot.data!.docs;
//                       if (docs.isEmpty) {
//                         return const Center(child: Text("No hay datos"));
//                       } else {
//                         _dropdownItems =
//                             docs.map<DropdownMenuItem<String>>((data) {
//                           return DropdownMenuItem<String>(
//                             value: data['nombre'],
//                             child: Text(data['nombre']),
//                           );
//                         }).toList();

//                         return DropdownButton<String>(
//                           hint: const Text('Selecciona una etiqueta'),
//                           value: _selectedValue,
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               _selectedValue = newValue;
//                             });
//                           },
//                           items: _dropdownItems,
//                         );
//                       }
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _cttController,
//                     decoration: const InputDecoration(
//                       labelText: "CTT",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _nombreEscuelaController,
//                     decoration: const InputDecoration(
//                       labelText: "Nombre de la escuela",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _nivelController,
//                     decoration: const InputDecoration(
//                       labelText: "Nivel",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _turnoController,
//                     decoration: const InputDecoration(
//                       labelText: "Turno",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _calleController,
//                     decoration: const InputDecoration(
//                       labelText: "Calle",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _coloniaController,
//                     decoration: const InputDecoration(
//                       labelText: "colonia",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _numeroController,
//                     decoration: const InputDecoration(
//                       labelText: "Numero",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _municipioController,
//                     decoration: const InputDecoration(
//                       labelText: "Municipio",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _nombreContactoController,
//                     decoration: const InputDecoration(
//                       labelText: "Nombre",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _apellidoContatoController,
//                     decoration: const InputDecoration(
//                       labelText: "Nombre",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: "Correo electronico",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _telefonoController,
//                     decoration: const InputDecoration(
//                       labelText: "Teléfono",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                     onPressed: () {
//                       final currentUser = _auth.currentUser;
//                       final title = _titleController.text;
//                       final description = _descripcionController.text;
//                       if (_formKey.currentState!.validate()) {
//                         // Guarda los nuevos datos de la escuela en la base de datos.
//                         FirebaseFirestore.instance
//                             .collection('usuarios')
//                             .doc(currentUser!.uid)
//                             .collection('escuelas')
//                             .doc(widget.escuelaId)
//                             .update(
//                           {
//                             'ctt': _cttController.text,
//                             'nombreEscuela': _nombreEscuelaController.text,
//                             'nivel': _nivelController.text,
//                             'turno': _turnoController.text,
//                             'calle': _calleController.text,
//                             'colonia': _coloniaController.text,
//                             'numero': _numeroController.text,
//                             'municipio': _municipioController.text,
//                             'codigoPostal': _cpController.text,
//                             'nombreContacto': _nombreContactoController.text,
//                             'apellidoContacto': _apellidoContatoController.text,
//                             'correoElectronico': _emailController.text,
//                             'telefono': _telefonoController.text,
//                             'etiqueta': _selectedValue.toString(),
//                           },
//                         );
//                         _addEvent();
//                         FirebaseFirestore.instance
//                             .collection('usuarios')
//                             .doc(currentUser.uid)
//                             .collection('contactos')
//                             .get()
//                             .then((querySnapshot) {
//                           querySnapshot.docs.forEach((doc) {
//                             doc.reference.update({
//                               'telefono': _telefonoController.text,
//                             });
//                           });
//                         });

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
//     final description = _descripcionController.text;
//     final currentUser = _auth.currentUser;
//     if (title.isEmpty) {
//       print('title cannot be empty');
//       return;
//     }

//     await FirebaseFirestore.instance
//         .collection('usuarios')
//         .doc(currentUser!.uid)
//         .collection('escuelas')
//         .add({
//       'etiqueta': _selectedValue.toString(),
//       "title": title,
//       "description": description,
//       'time': Timestamp.fromDate(_selectedTime).toDate(),
//       "date": dateFormat.parse(dateFormat.format(_selectedDate)),
//     });

//     if (mounted) {
//       Navigator.pop<bool>(context, true);
//     }
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class EditEscuelaScreen extends StatefulWidget {
//   final QueryDocumentSnapshot<Map<String, dynamic>> data;
//   final String escuelaId;

//   const EditEscuelaScreen({required this.data, required this.escuelaId});

//   @override
//   _EditEscuelaScreenState createState() => _EditEscuelaScreenState();
// }

// class _EditEscuelaScreenState extends State<EditEscuelaScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _cttController = TextEditingController();
//   final TextEditingController _nombreEscuelaController =
//       TextEditingController();
//   final TextEditingController _nivelController = TextEditingController();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descripcionController = TextEditingController();
//   final TextEditingController _turnoController = TextEditingController();
//   final TextEditingController _calleController = TextEditingController();
//   final TextEditingController _coloniaController = TextEditingController();
//   final TextEditingController _numeroController = TextEditingController();
//   final TextEditingController _municipioController = TextEditingController();
//   final TextEditingController _cpController = TextEditingController();
//   final TextEditingController _nombreController = TextEditingController();
//   final TextEditingController _apellidoController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _telefonoController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;

//   @override
//   void initState() {
//     super.initState();

//     _cttController.text =
//         widget.data['ctt'] != null ? widget.data['ctt'] : 'No hay ctt';

//     _nombreEscuelaController.text = widget.data['nombreEscuela'] != null
//         ? widget.data['nombreEscuela']
//         : 'No hay nombre';
//     _nivelController.text =
//         widget.data['nivel'] != null ? widget.data['nivel'] : 'No hay nivel';

//     _turnoController.text = widget.data['turno'] != null
//         ? widget.data['turno']
//         : 'No hay informacion';

//     _calleController.text =
//         widget.data['calle'] != null ? widget.data['calle'] : 'No hay nombre';

//     _coloniaController.text = widget.data['colonia'] != null
//         ? widget.data['colonia']
//         : 'No hay nombre';

//     _numeroController.text = widget.data['numero'] != null
//         ? widget.data['nombreEscuela']
//         : 'No hay nombre';

//     _municipioController.text = widget.data['municipio'] != null
//         ? widget.data['municipio']
//         : 'No hay nombre';
//     _cpController.text = widget.data['codigoPostal'] != null
//         ? widget.data['codigoPostal']
//         : 'No hay nombre';

//     _nombreController.text = widget.data['nombreContacto'] != null
//         ? widget.data['nombreContacto']
//         : 'No hay informacion';
//     _apellidoController.text = widget.data['apellidoContacto'] != null
//         ? widget.data['apellidoContacto']
//         : 'No hay informacion';
//     _emailController.text = widget.data['correoElectronico'] != null
//         ? widget.data['correoElectronico']
//         : 'No hay i';
//     // _nombreContactoController.text = widget.data['nombreContacto'];
//     _telefonoController.text =
//         widget.data['telefono'] != null ? widget.data['telefono'] : 'No hay i';
//   }

//   @override
//   void dispose() {
//     _nombreEscuelaController.dispose();
//     _nivelController.dispose();
//     // _nombreContactoController.dispose();
//     _telefonoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Editar Escuela"),
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
//                     controller: _cttController,
//                     decoration: const InputDecoration(
//                       labelText: "CTT",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _nombreEscuelaController,
//                     decoration: const InputDecoration(
//                       labelText: "Nombre de la escuela",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _nivelController,
//                     decoration: const InputDecoration(
//                       labelText: "Nivel",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _turnoController,
//                     decoration: const InputDecoration(
//                       labelText: "Turno",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _calleController,
//                     decoration: const InputDecoration(
//                       labelText: "Calle",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _coloniaController,
//                     decoration: const InputDecoration(
//                       labelText: "colonia",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _numeroController,
//                     decoration: const InputDecoration(
//                       labelText: "Numero",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _municipioController,
//                     decoration: const InputDecoration(
//                       labelText: "Municipio",
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
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 15),
//                 //   child: TextFormField(
//                 //     controller: _apellidoController,
//                 //     decoration: const InputDecoration(
//                 //       labelText: "Nombre y apellido",
//                 //     ),
//                 //   ),
//                 // ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: "Correo electronico",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextFormField(
//                     controller: _telefonoController,
//                     decoration: const InputDecoration(
//                       labelText: "Teléfono",
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       final currentUser = _auth.currentUser;
//                       if (_formKey.currentState!.validate()) {
//                         // Guarda los nuevos datos de la escuela en la base de datos.
//                         FirebaseFirestore.instance
//                             .collection('usuarios')
//                             .doc(currentUser!.uid)
//                             .collection('escuelas')
//                             .doc(widget.escuelaId)
//                             .update(
//                           {
//                             'nombreEscuela': _nombreEscuelaController.text,
//                             'nivel': _nivelController.text,
//                             'telefono': _telefonoController.text,
//                           },
//                         );
//                         FirebaseFirestore.instance
//                             .collection('usuarios')
//                             .doc(currentUser.uid)
//                             .collection('contactos')
//                             // .where('userId', isEqualTo: currentUser.uid)
//                             // .where('escuelaId', isEqualTo: widget.escuelaId)
//                             .get()
//                             .then((querySnapshot) {
//                           querySnapshot.docs.forEach((doc) {
//                             doc.reference.update({
//                               'telefono': _telefonoController.text,
//                             });
//                           });
//                         });

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
//       ),dsa
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditAllSchool extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String escuelaId;

  const EditAllSchool({required this.data, required this.escuelaId});

  @override
  _EditAllSchoolState createState() => _EditAllSchoolState();
}

class _EditAllSchoolState extends State<EditAllSchool> {
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> _dropdownItems = [];
  //Variables de edicion para cada apartado
  final TextEditingController _cttController = TextEditingController();
  final TextEditingController _nombreEscuelaController =
      TextEditingController();
  final TextEditingController _nivelController = TextEditingController();
  final TextEditingController _turnoController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _coloniaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _municipioController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _nombreContactoController =
      TextEditingController();
  final TextEditingController _apellidoContactoController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _etiquetaController = TextEditingController();
//
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.data['etiqueta'] ?? _selectedValue;
    // _selectedValue = widget.data['etiqueta'] != null
    //     ? widget.data['etiqueta']
    //     : _selectedValue;

    _cttController.text =
        widget.data['ctt'] != null ? widget.data['ctt'] : 'No hay ctt';

    _nombreEscuelaController.text = widget.data['nombreEscuela'] != null
        ? widget.data['nombreEscuela']
        : 'No hay nombre';
    _nivelController.text =
        widget.data['nivel'] != null ? widget.data['nivel'] : 'No hay nivel';

    _turnoController.text = widget.data['turno'] != null
        ? widget.data['turno']
        : 'No hay informacion';

    _calleController.text =
        widget.data['calle'] != null ? widget.data['calle'] : 'No hay nombre';

    _coloniaController.text = widget.data['colonia'] != null
        ? widget.data['colonia']
        : 'No hay nombre';

    _numeroController.text = widget.data['numero'] != null
        ? widget.data['nombreEscuela']
        : 'No hay nombre';

    _municipioController.text = widget.data['municipio'] != null
        ? widget.data['municipio']
        : 'No hay nombre';
    _cpController.text = widget.data['codigoPostal'] != null
        ? widget.data['codigoPostal']
        : 'No hay nombre';

    _nombreContactoController.text = widget.data['nombreContacto'] != null
        ? widget.data['nombreContacto']
        : 'No hay informacion';
    _apellidoContactoController.text = widget.data['apellidoContacto'] != null
        ? widget.data['apellidoContacto']
        : 'No hay informacion';
    _emailController.text = widget.data['correoElectronico'] != null
        ? widget.data['correoElectronico']
        : 'No hay informacion';
    _etiquetaController.text =
        widget.data['etiqueta'] != null ? widget.data['etiqueta'] : '';

    _telefonoController.text = widget.data['telefono'] != null
        ? widget.data['telefono']
        : 'No hay informacion';
  }

  @override
  void dispose() {
    _etiquetaController.dispose();
    _nombreEscuelaController.dispose();
    _cttController.dispose();
    _nivelController.dispose();
    _turnoController.dispose();
    _calleController.dispose();
    _coloniaController.dispose();
    _numeroController.dispose();
    _municipioController.dispose();
    _cpController.dispose();
    _nombreContactoController.dispose();
    _apellidoContactoController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        title: const Text("Editar Datos"),
        centerTitle: true,
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
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _auth.currentUser != null
                      ? FirebaseFirestore.instance
                          .collection('usuarios')
                          .doc(_auth.currentUser!.uid)
                          .collection('etiquetas')
                          // .where('nombre', isGreaterThanOrEqualTo: _searchText)
                          // .where('nombre', isLessThanOrEqualTo: _searchText + '\uf8ff')
                          .snapshots()
                      : const Stream.empty(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Error"));
                    } else {
                      final docs = snapshot.data!.docs;
                      if (docs.isEmpty) {
                        return const Center(child: Text("No hay datos"));
                      } else {
                        _dropdownItems =
                            docs.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem<String>(
                            value: data['nombre'],
                            child: Text(data['nombre']),
                          );
                        }).toList();

                        return DropdownButton<String>(
                          hint: const Text('Selecciona una etiqueta'),
                          value: _selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValue = newValue;
                            });
                          },
                          items: _dropdownItems,
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
                const Text('Datos de la Escuela',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                //Editar el nombre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _nombreEscuelaController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Nombre de la escuela (Obligatorio)',
                        hintText: 'Ingresa el nuevo nombre'),
                    //Validar Escuela
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce el nombre de la escuela';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el CTT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _cttController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'CTT',
                      hintText: 'Ingresa el nuevo CTT',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el nivel
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _nivelController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Nivel',
                      hintText: 'Ingresa el nuevo nivel',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el turno
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _turnoController,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Turno',
                      hintText: 'Ingresa el nuevo turno',
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
                        labelText: 'Calle', hintText: 'Ingresa la nueva calle'),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el numero
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _numeroController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Número',
                        hintText: 'Ingresa el nuevo número'),
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
                        hintText: 'Ingresa la nueva colonia'),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el Municipio
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _municipioController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Alcaldía / Municipio',
                        hintText: 'Ingresa el nuevo Municipio'),
                  ),
                ),

                const SizedBox(height: 20),

                //Editar el codigo postal
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _cpController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Código Postal',
                        hintText: 'Ingresa el nuevo código postal'),
                  ),
                ),

                const SizedBox(height: 20),
                const Text('Datos de contacto',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                //Editar el nombre de ocntacto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _nombreContactoController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Nombre', hintText: 'Ingresa el nombre'),
                  ),
                ),
                const SizedBox(height: 20),

                //Editar el nombre de ocntacto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _apellidoContactoController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Apellido', hintText: 'Ingresa su apellido'),
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

                const SizedBox(height: 20),

                //Editar el email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _emailController,
                    //Diseño del input
                    decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        hintText: 'Ingresa el nuevo correo electrónico'),
                  ),
                ),

                const SizedBox(height: 20),

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
                          .doc(widget.escuelaId)
                          .update(
                        {
                          'nombreEscuela': _nombreEscuelaController.text,
                          'nivel': _nivelController.text,
                          'telefono': _telefonoController.text,
                          'ctt': _cttController.text,
                          'turno': _turnoController.text,
                          'calle': _calleController.text,
                          'colonia': _coloniaController.text,
                          'numero': _numeroController.text,
                          'municipio': _municipioController.text,
                          'codigoPostal': _cpController.text,
                          'nombreContacto': _nombreContactoController.text,
                          'apellidoContacto': _apellidoContactoController.text,
                          'correoElectronico': _emailController.text,
                          'etiqueta': _selectedValue,
                        },
                      );
                      FirebaseFirestore.instance
                          .collection('usuarios')
                          .doc(currentUser.uid)
                          .collection('contactos')
                          .get()
                          .then((querySnapshot) {
                        querySnapshot.docs.forEach((doc) {
                          doc.reference.update({
                            'nombreContacto': _nombreContactoController.text,
                            'correoElectronico': _emailController.text,
                            'telefono': _telefonoController.text,
                          });
                        });
                      });

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
