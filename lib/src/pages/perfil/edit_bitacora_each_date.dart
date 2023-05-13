import 'package:app_ciudadana/src/pages/modulos/calendario/calendario_page.dart';
import 'package:app_ciudadana/src/pages/perfil/add_event_bitacora_school.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class EditBitagoraPage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String escuelaId;

  const EditBitagoraPage({required this.data, required this.escuelaId});

  @override
  _EditBitagoraPageState createState() => _EditBitagoraPageState();
}

class _EditBitagoraPageState extends State<EditBitagoraPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  DateTime day = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  final DateFormat timeFormat = DateFormat('HH:mm');
  final TextEditingController _cttController = TextEditingController();
  final TextEditingController _nombreEscuelaController =
      TextEditingController();
  final TextEditingController _nivelController = TextEditingController();
  final TextEditingController _nombreContactoController =
      TextEditingController();
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
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
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
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BitacoraEvent(
                        firstDate: _selectedDate,
                        lastDate: _selectedDate,
                      ),
                    ),
                  ),
              icon: Icon(Icons.calendar_month)),
        ],
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
                          },
                        );
                        FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(currentUser.uid)
                            .collection('contactos')
                            // .where('userId', isEqualTo: currentUser.uid)
                            // .where('escuelaId', isEqualTo: widget.escuelaId)
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
}
