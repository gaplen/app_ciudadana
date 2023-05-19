import 'package:app_ciudadana/src/pages/modulos/calendario/editar_evento_escuela.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventosEscuelaScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>? data;
  final String? idEvento;
  String idEscuela;

  EventosEscuelaScreen(
      {super.key, this.data, this.idEvento, required this.idEscuela});

  @override
  State<EventosEscuelaScreen> createState() =>
      _EventosEscuelaScreenState(idEscuela: idEscuela);
}

class _EventosEscuelaScreenState extends State<EventosEscuelaScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  final _dateFormat = DateFormat('dd/MM/yyyy');

  DateTime _selectedDate = DateTime.now();

  late DateTime _firstDay;
  late DateTime _lastDay;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _searchText = "";

  bool _showSearchBar = false;

  String idEscuela;
  _EventosEscuelaScreenState({required this.idEscuela});

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final currentDateString = _dateFormat.format(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _showSearchBar
              ? TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Buscar por título",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                )
              : const Center(child: Text('Eventos')),
        ),

        //Acción de busqueda
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _showSearchBar
                  //Boton de limpiar busqueda
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _showSearchBar = false;
                          _searchText = "";
                          _searchController.clear();
                        });
                      },
                    )

                  //Boton de busqueda
                  : IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _showSearchBar = true;
                        });
                      },
                    ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _auth.currentUser != null
            ? FirebaseFirestore.instance
                .collection('usuarios')
                .doc(_auth.currentUser!.uid)
                .collection('escuelas')
                .doc(idEscuela)
                .collection('eventos')
                .where('title', isGreaterThanOrEqualTo: _searchText)
                .where('title', isLessThanOrEqualTo: '$_searchText\uf8ff')
                .snapshots()
            : const Stream.empty(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else {
            final docs = snapshot.data!.docs;

            if (docs.isEmpty) {
              return const Center(child: Text("No hay datos"));
            } else {
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = docs[index];
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      data['date'].seconds * 1000);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          //Alineacion de contenido
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Container(
                              //Dimensiones de la tarjeta
                              height: 130,
                              width: 400,

                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink.shade900),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.pink.shade50,
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  //Alineacion de contenido
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    const SizedBox(width: 20),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xff59554e),
                                            radius: 35,
                                            backgroundImage: AssetImage(
                                                'assets/calendar.png'),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 11),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //Mostrar la fecha
                                              RichText(
                                                text: TextSpan(
                                                    text: 'Fecha: ',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    children: [
                                                      TextSpan(
                                                        text: _dateFormat
                                                            .format(date),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      )
                                                    ]),
                                              ),

                                              const SizedBox(height: 5),

                                              //Mostrar el titulo
                                              RichText(
                                                text: TextSpan(
                                                    text: 'Título: ',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${data['title']}',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      )
                                                    ]),
                                              ),

                                              const SizedBox(height: 5),

                                              //Mostrar la descripción
                                              SizedBox(
                                                //Definir el ancho para que no sobrepase los pixeles
                                                width: 197,
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: 'Descripción: ',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              '${data['description']}',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        )
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //Boton editar
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      EventoEditPage(
                                                    data: data,
                                                    idEvento: data.id,
                                                    idEscuela: idEscuela,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
