import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BitacoraEditPage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String escuelaId;

  BitacoraEditPage({required this.data, required this.escuelaId});

  @override
  _BitacoraEditPageState createState() => _BitacoraEditPageState();
}

class _BitacoraEditPageState extends State<BitacoraEditPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();

  DateTime _selectedTime = DateTime.now();
  final DateFormat timeFormat = DateFormat('HH:mm');
  DateTime day = DateTime.now();

  @override
  void initState() {
    super.initState();

    titleController.text =
        widget.data['title'] != null ? widget.data['title'] : 'No hay titulo';
    descriptionController.text = widget.data['description'] != null
        ? widget.data['description']
        : 'No hay descripcion';
    final lastDate = DateTime.now() != null ? DateTime.now() : DateTime.now();
    // DateTime _selectedDate =
    //     DateTime.fromMillisecondsSinceEpoch(widget.data['date'].seconds * 1000);

    final date =
        DateTime.fromMillisecondsSinceEpoch(widget.data['date'].seconds * 1000);

    _selectedDate = widget.data['date'] != null ? date : lastDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff59554e),
        title: const Text('Editar evento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.25,
                    // height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        // color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.date_range),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                // color: Colors.red,
                                width:
                                    MediaQuery.of(context).size.height * 0.20,
                                child: Text(
                                  'Fecha: ${dateFormat.format(_selectedDate)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
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
                                    color: Colors.black,
                                    width: 1,
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
                          ],
                        )
                      ],
                    ),
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
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final currentUser = _auth.currentUser;
                      Future.delayed(Duration(seconds: 5), () {
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Formulario agregado correctamente'),
                          ),
                        );
                        Navigator.pop(
                            context); // Cerrar el formulario después de 10 segundos
                      });
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
                            'hora': timeFormat.format(_selectedTime),
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
                    ),
                  ),
                ),
                // ElevatedButton(onPressed: () {}, child: Text('Crear evento')),
              ],
            ),
          ),
        ),
      ),
    );
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateFormat.parse(dateFormat.format(_selectedDate)),
      //  dateFormat.parse(dateFormat.format(date)),

      firstDate: day,
      // lastDate: DateTime.now(2100),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
    final eventos = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: _selectedDate)
        .where('date', isLessThanOrEqualTo: _selectedDate)
        .get();
  }
}
