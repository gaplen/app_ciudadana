import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'agendar_evento.dart';

import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const AddEvent({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _auth = FirebaseAuth.instance;
  // late DateTime _selectedDate;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  DateTime day = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
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
          // padding: const EdgeInsets.all(16.0),
          children: [
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
                    width: MediaQuery.of(context).size.height * 0.21,
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
      // dateFormat.parse(dateFormat.format(_selectedDate)),
      firstDate: dateFormat.parse(dateFormat.format(day)),
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

  void _addEvent() async {
    final title = _titleController.text;
    final description = _descController.text;
    final currentUser = _auth.currentUser;
    if (title.isEmpty) {
      print('title cannot be empty');
      return;
    }
    // final adjustedDate = _selectedDate.toLocal();
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(currentUser!.uid)
        .collection('events')
        .add({
      "title": title,
      "description": description,
      // "date": _selectDate(context),
      "date": dateFormat.parse(dateFormat.format(_selectedDate)),
      // Timestamp.fromDate(_selectedDate).toDate(),
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
