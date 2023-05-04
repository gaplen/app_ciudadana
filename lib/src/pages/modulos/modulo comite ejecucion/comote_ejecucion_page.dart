import 'package:app_ciudadana/src/pages/modulos/modulo%20comite%20ejecucion/edit_comite_ejecucion.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/modulos_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'comite_ejecucion.dart';

class ComiteEjecucionPage extends StatefulWidget {
  const ComiteEjecucionPage({super.key});

  @override
  State<ComiteEjecucionPage> createState() => _ComiteEjecucionPageState();
}

class _ComiteEjecucionPageState extends State<ComiteEjecucionPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";

  bool _showSearchBar = false;
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
              : Center(child: Text("Comite de ejecucion")),
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
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => RegistroComitePage()),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _auth.currentUser != null
            ? FirebaseFirestore.instance
                .collection('usuarios')
                .doc(_auth.currentUser!.uid)
                .collection('comiteEjecucion')
                .where('nombre', isGreaterThanOrEqualTo: _searchText)
                .where('nombre', isLessThanOrEqualTo: _searchText + '\uf8ff')
                .snapshots()
            // .collection('usuarios')
            // // .where(_auth.currentUser!.uid,
            // //     isEqualTo: _auth.currentUser!.uid)
            // .snapshots()
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffe2e3d9),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 25),
                                Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 12),
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xff59554e),
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage('assets/comite.png'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            // color: Colors.red,
                                            child: Text(
                                              'Puesto    : ${data['puesto']}',
                                              // data['nombreEscuela'].toString(),
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            // color: Colors.red,
                                            child: Text(
                                              'Nombre  : ${data['nombre']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            // color: Colors.red,
                                            child: Text(
                                              'Telefono: ${data['telefono']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  EditEjecucionScreen(
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
