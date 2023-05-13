import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class EditAllSchool extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String escuelaId;
  final DateTime? selectedDate;

  const EditAllSchool(
      {required this.data, required this.escuelaId, this.selectedDate});

  @override
  _EditAllSchoolState createState() => _EditAllSchoolState();
}

class _EditAllSchoolState extends State<EditAllSchool> {
  List<DropdownMenuItem<String>> _dropdownItems = [];
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  DateTime day = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  final DateFormat timeFormat = DateFormat('HH:mm');

  late String _selectedItem;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cttController = TextEditingController();
  final TextEditingController _nombreEscuelaController =
      TextEditingController();
  final TextEditingController _nivelController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _turnoController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _coloniaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _municipioController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _nombreandlastnameController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  final TextEditingController _etiquetaController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String? _selectedValue;

  List<String> _turnoOptions = ['Mañana', 'Tarde', 'Noche'];

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.data['etiqueta'] ?? _selectedValue;
    String _selectedTurno = widget.data['turno'] ?? _turnoOptions[0];

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

    _nombreandlastnameController.text = widget.data['nombreContacto'] != null
        ? widget.data['nombreContacto']
        : 'No hay informacion';
    _emailController.text = widget.data['correoElectronico'] != null
        ? widget.data['correoElectronico']
        : 'No hay i';
    // _nombreContactoController.text = widget.data['nombreContacto'];
    _telefonoController.text =
        widget.data['telefono'] != null ? widget.data['telefono'] : 'No hay i';
    _etiquetaController.text =
        widget.data['etiqueta'] != null ? widget.data['etiqueta'] : '';
    _selectedDate = widget.selectedDate ?? DateTime.now();
    _selectedTime = timeFormat.parse(timeFormat.format(_selectedTime));
  }

  @override
  void dispose() {
    _nombreEscuelaController.dispose();
    _nivelController.dispose();
    // _nombreContactoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Escuela"),
        backgroundColor: Color(0xff59554e),
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
              children: [
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _cttController,
                    decoration: const InputDecoration(
                      labelText: "CTT",
                    ),
                  ),
                ),
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
                    controller: _turnoController,
                    decoration: const InputDecoration(
                      labelText: "Turno",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _calleController,
                    decoration: const InputDecoration(
                      labelText: "Calle",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _coloniaController,
                    decoration: const InputDecoration(
                      labelText: "colonia",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _numeroController,
                    decoration: const InputDecoration(
                      labelText: "Numero",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _municipioController,
                    decoration: const InputDecoration(
                      labelText: "Municipio",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _nombreandlastnameController,
                    decoration: const InputDecoration(
                      labelText: "Nombre y apellido",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Correo electronico",
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
                      final currentUser = _auth.currentUser;
                      final title = _titleController.text;
                      final description = _descripcionController.text;
                      if (_formKey.currentState!.validate()) {
                        // Guarda los nuevos datos de la escuela en la base de datos.
                        FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(currentUser!.uid)
                            .collection('escuelas')
                            .doc(widget.escuelaId)
                            .update(
                          {
                            'ctt': _cttController.text,
                            'nombreEscuela': _nombreEscuelaController.text,
                            'nivel': _nivelController.text,
                            'turno': _turnoController.text,
                            'calle': _calleController.text,
                            'colonia': _coloniaController.text,
                            'numero': _numeroController.text,
                            'municipio': _municipioController.text,
                            'codigoPostal': _cpController.text,
                            'nombreContacto': _nombreandlastnameController.text,
                            'correoElectronico': _emailController.text,
                            'telefono': _telefonoController.text,
                            'etiqueta': _selectedValue.toString(),
                          },
                        );
                        _addEvent();
                        FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(currentUser.uid)
                            .collection('contactos')
                            .get()
                            .then((querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            doc.reference.update({
                              'telefono': _telefonoController.text,
                            });
                          });
                        });

                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Guardar cambios"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff8c6d62)),
                    )),
                const SizedBox(height: 20),
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
      firstDate: dateFormat.parse(dateFormat.format(day)),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
    final eventos = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('escuelas')
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
    final description = _descripcionController.text;
    final currentUser = _auth.currentUser;
    if (title.isEmpty) {
      print('title cannot be empty');
      return;
    }

    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(currentUser!.uid)
        .collection('escuelas')
        .add({
      'etiqueta': _selectedValue.toString(),
      "title": title,
      "description": description,
      'time': Timestamp.fromDate(_selectedTime).toDate(),
      "date": dateFormat.parse(dateFormat.format(_selectedDate)),
    });

    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
