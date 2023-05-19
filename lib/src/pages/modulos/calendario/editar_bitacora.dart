import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BitacoraEditPage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String idBitacora;
  String idEscuela;

  BitacoraEditPage(
      {super.key,
      required this.data,
      required this.idBitacora,
      required this.idEscuela});

  @override
  _BitacoraEditPageState createState() =>
      _BitacoraEditPageState(idEscuela: idEscuela);
}

class _BitacoraEditPageState extends State<BitacoraEditPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  DateTime day = DateTime.now();

  String idEscuela;
  _BitacoraEditPageState({required this.idEscuela});

  @override
  void initState() {
    super.initState();

    titleController.text = widget.data['title'] ?? '';
    descriptionController.text = widget.data['description'] ?? '';

    final lastDate = DateTime.now() != null ? DateTime.now() : DateTime.now();

    final date =
        DateTime.fromMillisecondsSinceEpoch(widget.data['date'].seconds * 1000);

    _selectedDate = widget.data['date'] != null ? date : lastDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar datos'),
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
                  child: SizedBox(
                    width: 200,
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.date_range),

                          const SizedBox(width: 10),

                          //Mostrar fecha
                          RichText(
                            text: TextSpan(
                                text: 'Fecha: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 17),
                                children: [
                                  TextSpan(
                                    text: dateFormat.format(_selectedDate),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    hintText: 'Ingresa el nuevo título',
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    hintText: 'Ingresa la nueva descripción',
                  ),
                  maxLines: 7,
                  maxLength: 300,
                ),

                const SizedBox(height: 10),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final currentUser = _auth.currentUser;

                      Future.delayed(const Duration(seconds: 3), () {
                        const CircularProgressIndicator(
                            backgroundColor: Colors.pink);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Formulario agregado correctamente')),
                        );
                        Navigator.pop(
                            context); // Cerrar el formulario después de 10 segundos
                      });

                      if (_formKey.currentState!.validate()) {
                        // Guarda los nuevos datos de la escuela en la base de datos.
                        FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(currentUser!.uid)
                            .collection('escuelas')
                            .doc(idEscuela)
                            .collection('bitacora')
                            .doc(widget.idBitacora)
                            .update(
                          {
                            'date': Timestamp.fromDate(_selectedDate),
                            'title': titleController.text,
                            'description': descriptionController.text,
                          },
                        );
                        Navigator.pop(context);
                      }
                    },
                    //Diseño/Estilo del botón
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      elevation: 0,
                      shadowColor: Colors.pink.shade900,
                    ),

                    child: const Text("Guardar cambios"),
                  ),
                ),
                const SizedBox(height: 100),
                // ElevatedButton(onPressed: () {}, child: Text('Crear evento')),
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
      //  dateFormat.parse(dateFormat.format(date)),

      firstDate: day,
      // lastDate: DateTime.now(2100),
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
        .collection('bitacora')
        .where('date', isGreaterThanOrEqualTo: _selectedDate)
        .where('date', isLessThanOrEqualTo: _selectedDate)
        .get();
  }
}
