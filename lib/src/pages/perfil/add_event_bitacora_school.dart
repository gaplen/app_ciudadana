import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class BitacoraEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const BitacoraEvent({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<BitacoraEvent> createState() => _BitacoraEventState();
}

class _BitacoraEventState extends State<BitacoraEvent> {
  final _auth = FirebaseAuth.instance;
  // late DateTime _selectedDate;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  DateTime day = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  final DateFormat timeFormat = DateFormat('HH:mm');

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
        title: const Text("Nuevo Evento"),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Container(
                width: MediaQuery.of(context).size.height * 0.20,
                child: GestureDetector(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple.shade200,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.purple.shade200,
                        ),
                        SizedBox(width: 5),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple.shade200,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    // color: Colors.red,
                    width: MediaQuery.of(context).size.height * 0.22,
                    // height: 20,
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.purple.shade200,
                        ),
                        SizedBox(width: 5),
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
            TextField(
              controller: _titleController,
              maxLines: 1,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
              controller: _descController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Descripcion'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.purple.shade200),
              ),
              onPressed: () {
                // _updateEvent();
                _addEvent();
              },
              child: const Text("Guardar"),
            ),
          ],
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

  void _updateEvent() async {
    final title = _titleController.text;
    final description = _descController.text;
    final currentUser = _auth.currentUser;
    if (title.isEmpty) {
      print('title cannot be empty');
      return;
    }

    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(currentUser!.uid)
        .collection('escuelas')
        .doc(_auth.currentUser!.uid)
        .update({
      "title": title,
      "description": description,
      'time': Timestamp.fromDate(_selectedTime).toDate(),
      "date": dateFormat.parse(dateFormat.format(_selectedDate)),
    });

    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }

  void _addEvent() async {
    Future.delayed(Duration(seconds: 5), () {
      CircularProgressIndicator(
        backgroundColor: Colors.white,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Formulario agregado correctamente'),
        ),
      );
      Navigator.pop(context); // Cerrar el formulario después de 10 segundos
    });
    final title = _titleController.text;
    final description = _descController.text;
    final currentUser = _auth.currentUser;
    if (title.isEmpty) {
      print('title cannot be empty');
      return;
    }

    // await FirebaseFirestore.instance
    //     .collection('usuarios')
    //     .doc(currentUser!.uid)
    //     .collection('escuelas')
    //     .add({
    //   "title": title,
    //   "description": description,
    //   'time': Timestamp.fromDate(_selectedTime).toDate(),
    //   "date": dateFormat.parse(dateFormat.format(_selectedDate)),
    // });

    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
