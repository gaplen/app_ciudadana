import 'package:app_ciudadana/src/pages/modulos/calendario/add_event.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/edit_all_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/edit_page_escuelas.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/opciones_escuela.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/modulos_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class VerEscuelasPage extends StatefulWidget {
  const VerEscuelasPage({super.key});

  @override
  State<VerEscuelasPage> createState() => _EscuelasPageState();
}

class _EscuelasPageState extends State<VerEscuelasPage> {
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();
  DateTime day = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  final DateFormat timeFormat = DateFormat('HH:mm');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";
  bool _showSearchBar = false;
  // String _searchText = "";
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: _showSearchBar
              ? TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Buscar...",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                )
              : Center(child: Text("Escuelass")),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: _showSearchBar
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _showSearchBar = false;
                          _searchText = "";
                          _searchController.clear();
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff59554e),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => AddEvent(
                      firstDate: _selectedDate,
                      lastDate: _selectedDate,
                    )),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _auth.currentUser != null
            ? FirebaseFirestore.instance
                .collection('usuarios')
                .doc(_auth.currentUser!.uid)
                .collection('escuelas')
                .where('nombreEscuela', isGreaterThanOrEqualTo: _searchText)
                .where('nombreEscuela',
                    isLessThanOrEqualTo: _searchText + '\uf8ff')
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

                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      right: 15,
                      left: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color(0xffe2e3d9),
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 25),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Color(0xff59554e),
                                      backgroundImage:
                                          AssetImage('assets/escuela.png'),
                                      child: Container(),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    // color: Colors.red,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        // color: Colors.red,
                                        child: Text(
                                          'Escuela  : ${data['nombreEscuela'] != null ? data['nombreEscuela'] : ''}',

                                          // 'Escuela  : ${data['nombreEscuela']}',
                                          overflow: TextOverflow.ellipsis,
                                          // data['nombreEscuela'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Nivel       : ${data['nivel'] != null ? data['nivel'] : 'No hay nivel'}',
                                        // 'Nivel       : ${data['nivel']}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Telefono: ${data['telefono'] != null ? data['telefono'] : 'No hay telefono'}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Etiqueta: ${data['etiqueta'] != null ? data['etiqueta'] : 'No hay telefono'}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Fecha: ${_selectedDate != null ? dateFormat.format(_selectedDate) : 'No hay fecha'}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Hora: ${_selectedTime != null ? timeFormat.format(_selectedTime) : 'No hay fecha'}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => EditAllSchool(
                                              data: data,
                                              escuelaId: data.id,
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
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
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
