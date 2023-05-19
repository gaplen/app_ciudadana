import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AddBitacora extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  String idEscuela;

  AddBitacora({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    this.selectedDate,
    required this.idEscuela,
  }) : super(key: key);

  @override
  State<AddBitacora> createState() => _AddBitacoraState(idEscuela: idEscuela);
}

class _AddBitacoraState extends State<AddBitacora> {
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
  _AddBitacoraState({required this.idEscuela});

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
        centerTitle: true,
        title: const Text("Nuevo Registro"),
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

                          //Mostrar hora
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

                          //Mostrar Fecha
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

              //Titulo del Registro
              TextField(
                controller: _titleController,
                //Diseño del input
                decoration: InputDecoration(
                  labelText: 'Titulo',
                  hintText: 'Ingresa el nombre del evento',
                ),
              ),

              const SizedBox(height: 20),

              //Descripción del registro
              TextField(
                controller: _descController,
                //Tamaño y longitud del texto
                maxLines: 15,
                maxLength: 300,
                //Diseño del input
                decoration: InputDecoration(
                    labelText: 'Descripcion', hintText: 'Ingrese el registro'),
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

                    child: const Text('Guardar Registro'),
                  ),
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
        .collection('escuelas')
        .doc(idEscuela)
        .collection('bitacora')
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
    Future.delayed(const Duration(seconds: 5), () {
      CircularProgressIndicator(backgroundColor: Colors.pink.shade800);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario agregado correctamente')),
      );
      Navigator.pop(context); // Cerrar el formulario después de 10 segundos
    });

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
        .collection('bitacora')
        .add({
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
