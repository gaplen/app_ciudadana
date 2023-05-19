import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/edit_page_escuelas.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/modulos_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/registro_escuelas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EscuelasScreen extends StatefulWidget {
  const EscuelasScreen({super.key});

  @override
  State<EscuelasScreen> createState() => _EscuelasScreenState();
}

class _EscuelasScreenState extends State<EscuelasScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";
  bool _showSearchBar = false;

  var name = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _showSearchBar
                ? TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Buscar...",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                  )
                : const Center(child: Text("Escuelas")),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _showSearchBar
                    //Boton de limpiar
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

        //Botón para registrar escuela
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => RegistroEscuela()),
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
                        isLessThanOrEqualTo: '$_searchText\uf8ff')
                    .snapshots()
                : const Stream.empty(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              } else {
                final docs1 = snapshot.data!.docs;
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _auth.currentUser != null
                      ? FirebaseFirestore.instance
                          .collection('usuarios')
                          .doc(_auth.currentUser!.uid)
                          .collection('escuelas')
                          .where(
                            'nombreContacto',
                            isEqualTo: _searchText,
                          )
                          .snapshots()
                      : const Stream.empty(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot2.hasError) {
                      return const Center(child: Text("Error"));
                    } else {
                      final docs2 = snapshot2.data!.docs;
                      // final combinedDocs = [...docs1, ...docs2];
                      final combinedDocs =
                          [...docs1, ...docs2].toSet().toList();
                      if (combinedDocs.isEmpty) {
                        return const Center(child: Text("No hay datos"));
                      } else {
                        return ListView.builder(
                          itemCount: combinedDocs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = combinedDocs[index];

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
                                  GestureDetector(
                                    onTap: () {
                                      String idSchool = data.id;

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ModulosScreen(
                                            idEscuela: idSchool,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Color(0xffe2e3d9),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: 25),
                                          Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: AssetImage(
                                                      'assets/escuela.png'),
                                                ),
                                              ),

                                              const SizedBox(
                                                  height: 10, width: 10),

                                              //Mostrar datos
                                              Column(
                                                children: [
                                                  //Mostrar nombre de escuela
                                                  SizedBox(
                                                    //Definir el ancho para que no sobrepase los pixeles
                                                    width: 190,

                                                    child: RichText(
                                                      text: TextSpan(
                                                          text: 'Escuela: ',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '${data['nombreEscuela'] != null ? data['nombreEscuela'] : 'No hay informacion'}',
                                                              //
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )
                                                          ]),
                                                    ),
                                                  ),

                                                  const SizedBox(height: 5),

                                                  //Mostrar nivel
                                                  SizedBox(
                                                    //Definir el ancho para que no sobrepase los pixeles
                                                    width: 190,

                                                    child: RichText(
                                                      text: TextSpan(
                                                          text: 'Nivel: ',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '${data['nivel'] != null ? data['nivel'] : 'No hay nivel'}',
                                                              //
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )
                                                          ]),
                                                    ),
                                                  ),

                                                  const SizedBox(height: 5),

                                                  //Mostrar nombre de ocntacto
                                                  SizedBox(
                                                    //Definir el ancho para que no sobrepase los pixeles
                                                    width: 190,

                                                    child: RichText(
                                                      text: TextSpan(
                                                          text: 'Contacto: ',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '${data['nombreContacto'] != null ? data['nombreContacto'] : 'No hay informacion'}',
                                                              //
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis),
                                                            )
                                                          ]),
                                                    ),
                                                  ),

                                                  const SizedBox(height: 5),

                                                  //Mostrar telefono
                                                  SizedBox(
                                                    //Definir el ancho para que no sobrepase los pixeles
                                                    width: 190,

                                                    child: RichText(
                                                      text: TextSpan(
                                                          text: 'Teléfono: ',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '${data['telefono'] != null ? data['telefono'] : 'No hay informacion'}',
                                                              //
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              //Boton para editar datos
                                              Column(
                                                children: [
                                                  //Boton al menú de opciones
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 50.0),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        String idSchool =
                                                            data.id;

                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                ModulosScreen(
                                                              idEscuela:
                                                                  idSchool,
                                                            ),
                                                          ),
                                                        );
                                                        print(data.id);
                                                      },
                                                      icon: const Icon(
                                                          Icons.event),
                                                    ),
                                                  ),

                                                  //Botón de editar datos
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 50.0),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                EditEscuelaScreen(
                                                              data: data,
                                                              escuelaId:
                                                                  data.id,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                );
              }
            }));
  }
}
